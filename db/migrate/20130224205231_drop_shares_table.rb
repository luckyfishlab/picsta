class DropSharesTable < ActiveRecord::Migration
  def up
    drop_table :shares
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
