class CreateAlbumStats < ActiveRecord::Migration
  def change
    create_table :album_stats do |t|
      t.integer :album_id
      t.integer :last_image_count

      t.timestamps
    end
  end
end
