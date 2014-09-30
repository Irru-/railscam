class CreateBlobs < ActiveRecord::Migration
  def change
    create_table :blobs do |t|
      t.string      :filename
      t.string      :filetype
      t.string      :extension
      t.string      :sha1d
      t.timestamps
    end
  end
end
