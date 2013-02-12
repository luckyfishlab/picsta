class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    Power.current = Power.new(current_user)
    if Power.current.is_admin == true
      @users = end_of_association_chain.all
      respond_to do |format|
        format.html # index.html.erb
      end
    else
      flash[:notice] = "Access not available"
      redirect_to root_path
    end
  end

  def show
    Power.current = Power.new(current_user)
    if Power.current.is_admin == true
      @user = end_of_association_chain.find(params[:id])
      respond_to do |format|
        format.html # index.html.erb
      end
    else
      flash[:notice] = "Access not available"
      redirect_to root_path
    end

  end

  def update
    Power.current = Power.new(current_user)
    if Power.current.is_admin == true
      @user = User.find(params[:id])
      if true #@user.update_attributes(params[:user], :as => :admin)
        puts params[:user]
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    else
      flash[:notice] = "Access not available"
      redirect_to root_path
    end
  end


  def end_of_association_chain
    #Power.current ||= Power.new(current_user)
    Power.current.users
  end


end
