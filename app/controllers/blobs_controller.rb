class BlobsController < ApplicationController

	def new
		@blob = Blob.new
	end

	def create
		file_path = params[:blob][:file_input].tempfile.path
		sha1 = `./../../camlistore/bin/camput blob #{file_path}`
		filename = params[:blob][:file_input].original_filename
		type = params[:blob][:file_input].content_type
		
		shared_with = params[:blob][:shared_with]
		shared_with.shift

		@blob = Blob.new(blob_params)
		@blob[:filename] = filename
		@blob[:filetype] = type
		@blob[:sha1d] = sha1
		@blob[:user_id] = current_user.id

		logger.debug "Shared_with = #{params[:blob][:shared_with]}"

		params[:blob][:shared_with].each do |id|

			user = User.find(id)
			@blob.users << user

		end

		if @blob.save
			redirect_to blobs_path
		else
			render 'new'
		end
	end

	def index
		if signed_in?
			@blobs = Blob.where(:user_id => current_user.id)
		else
			@blobs = Blob.all
		end
	end

	def shared
		@blobs = current_user.shared_blobs
	end

	def show
		blob = Blob.find(params[:id])		

		sha1 = blob.sha1d[0..-2]

		send_data `./../../camlistore/bin/camget #{sha1}`, :filename => blob.filename, :disposition => 'inline'
	end


	private

		def blob_params
			params.require(:blob).permit(:filename, :filetype, :extension, :sha1d, :user_id)
		end
end
