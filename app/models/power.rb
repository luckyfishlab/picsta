class Power
  include Consul::Power


  # This is called from application_controller.rb
  # and is available as "current_power" or Power.current while
  # the request is being served
  def initialize(user)
    @user = user
  end

  power :current_group do
    @user.groups.first
  end

  power :albums do
    group_id = @user.groups.first
    folder = Folder.where(:group_id => group_id).first
    Album.where(:folder_id => folder.id)
  end

  power :images do
    Image
  end

  power :users do
    User if is_admin?
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
    Album #.where(:user_id => @user.id)
  end


end
