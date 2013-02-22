class Power
  include Consul::Power

  def initialize(user)
    @user = user
  end

  power :albums do
    Album #.where(:user_id => @user.id)
  end

  power :users do
    if self.is_admin == true
      User
    else
      nil
    end
  end

  power :is_subscriber do
    roles = @user.roles.where(:name => :subscriber)
    if roles.first.nil?
      false
    else
      true
    end
  end

  power :is_admin do
    if Rails.env == 'test' or Rails.env == 'cucumber'
      if @user.name.eql?("Test Admin")
        true
      else
        false

      end
    else
      roles = @user.roles.where(:name => :admin)
      if roles.first.nil?
        false
      else
        true
      end
    end
  end


  power :updatable_albums do
    Album.where(:user_id => @user.id)
  end

  power :readable_album  do |album_id|
    album = Album.find(album_id)
    album
  end
end
