class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_power.is_admin == true
      @users = end_of_association_chain.all
      @roles = Role.all
      respond_to do |format|
        format.html # index.html.erb
      end
    else
      flash[:alert] = "Access not available"
      redirect_to root_path
    end
  end

  def show

    if current_power.is_admin == true
      @user = end_of_association_chain.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
      end
    else
      flash[:alert] = "Access not available"
      redirect_to root_path
    end
  end

  def update

    if current_power.is_admin == true
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    else
      flash[:alert] = "Access not available"
      redirect_to root_path
    end
  end


  def end_of_association_chain
    current_power.users
  end


end
