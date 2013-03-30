class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :albums, :user_id
    add_index :albums, :folder_id
    add_index :albums, :image_id
    add_index :album_stats, :album_id
    add_index :folders, :group_id
    add_index :group_users, :user_id
    add_index :group_users, :group_id
    add_index :images, :album_id
    add_index :memberships, :user_id
    add_index :memberships, :role_id
    add_index :subscriptions, :plan_id
    add_index :subscriptions, :user_id
  end
end
