class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.integer :group_id

      t.timestamps
    end
  end
end
