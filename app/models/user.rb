class User < ActiveRecord::Base
	before_create :create_remember_token
  has_many  :owned_blobs, :class_name => "Blob"
  has_and_belongs_to_many :shared_blobs, :class_name => "Blob"

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	private

    	def create_remember_token
      		self.remember_token = User.digest(User.new_remember_token)
    	end
end
