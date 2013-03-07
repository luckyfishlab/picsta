class AddGroupToUserInvitation < ActiveRecord::Migration
  def change
    add_column :users, :invited_by_group_id, :integer
  end
end
