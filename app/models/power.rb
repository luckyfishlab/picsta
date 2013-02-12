class Power
  include Consul::Power

  def initialize(user)
    @user = user
  end

  power :albums do
    Album.where(:user_id => @user.id)
  end

  power :users do
    if self.is_admin == true
      User
    else
      nil
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
      if @user.name.eql?("Dana Spisak")
        true
      else
        false
      end
    end
  end

=begin
    @members = Membership.all
    roles = @user.roles.where(:name => :admin)
    if roles.first
      true
    else
      false
    end
    end
=end

  power :updatable_albums do
    Album.where(:user_id => @user.id)
  end

  power :readable_album  do |album_id|
    album = Album.find(album_id)
    if album.user_id == @user.id
      album
    else
      allowed = album.allowed_viewers.map(&:id)
      if allowed.include? @user.id
        album
      else
        nil
      end
    end
  end
end
