class AddFolderToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :folder_id, :integer
  end
end
