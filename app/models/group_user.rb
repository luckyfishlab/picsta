class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :user_id

  validates_uniqueness_of :user_id, :scope => [:group_id]

  belongs_to :user
  belongs_to :group
end
