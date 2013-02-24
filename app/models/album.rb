class Album < ActiveRecord::Base
  include PublicActivity::Common


  attr_accessible :title, :user_id

  belongs_to :user
  has_many :images
  has_one :album_stat, dependent: :destroy
  after_create :create_album_stat


end
