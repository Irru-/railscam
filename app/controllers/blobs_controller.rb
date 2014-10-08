class BlobsController < ApplicationController

	def new
		@blob = Blob.new
	end

	def create		
		shared_with = params[:blob][:shared_with]
		shared_with.shift

		@blob = Blob.new(blob_params)
		@blob[:user_id] = current_user.id

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
			params.require(:blob).permit(:file_input, :filename, :filetype, :extension, :sha1d, :user_id)
		end
end
