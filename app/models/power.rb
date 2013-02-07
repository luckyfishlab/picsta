class Power
  include Consul::Power

  def initialize(user)
    @user = user
  end


  power :albums do
    Album.where(:user_id => @user.id)
  end
=begin
  power :editable_album?:album_id
    album = Album.find(album_id)
    if album.user_id == @user.id
      true
    else
      false
    end
  end
=end
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
