class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :album_id
      t.integer :user_id

      t.timestamps
    end

    add_index :shares, :album_id
    add_index :shares, :user_id
    add_index :shares, [:album_id, :user_id], unique: true
  end
end
