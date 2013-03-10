class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :plan_id
      t.integer :user_id
      t.string :customer_id
      t.string :last_4_digits

      t.timestamps
    end
  end
end
