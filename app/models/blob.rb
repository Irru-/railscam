class Blob < ActiveRecord::Base
	belongs_to	:user
	has_and_belongs_to_many	:users
	before_save :file_input_process

	attr_accessor :file_input

	def file_input_process

		logger.debug ":file_input.original_filename = #{file_input.original_filename}"

		filepath = file_input.tempfile.path
		self.filename = file_input.original_filename
		self.filetype = file_input.content_type
		self.sha1d	 = `./../../camlistore/bin/camput blob #{filepath}`

	end



end
