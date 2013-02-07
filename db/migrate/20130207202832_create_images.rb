class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.integer :album_id
      t.string :pic

      t.timestamps
    end
  end
end
