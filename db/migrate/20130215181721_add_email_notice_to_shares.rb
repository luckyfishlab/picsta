class AddEmailNoticeToShares < ActiveRecord::Migration
  def change
    add_column :shares, :email_notice, :integer
  end
end
