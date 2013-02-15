class Share < ActiveRecord::Base
  attr_accessible :user_id #,:album_id

  belongs_to :album
  belongs_to :user


end
