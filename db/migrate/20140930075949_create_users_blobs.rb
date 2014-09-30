class CreateUsersBlobs < ActiveRecord::Migration
  def change
    create_table :blobs_users, :id => false do |t|
    	t.references :user
    	t.references :blob
  	end
  end

  def self.down
	drop_table :articles_categories
  end
end
