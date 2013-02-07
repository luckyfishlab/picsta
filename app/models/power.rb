class Power
  include Consul::Power

  def initialize(user)
    @user = user
  end


  power :albums do
    Album.where(:user_id => @user.id)
  end

  power :shared_albums do
    Share.where(:user_id => @user.id)
  end
end
