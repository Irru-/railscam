class AddOwnerSharedWithToBlobs < ActiveRecord::Migration
  def change
  	add_column :blobs, :user_id, :integer
  	add_column :blobs, :shared_with, :text	
  end
end
