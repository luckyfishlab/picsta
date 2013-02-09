class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
   # Power.current ||= Power.new(current_user)
   # if Power.current.users!
   #   @users =  end_association_chain.all
   # end
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  def end_association_chain
    Power.current = Power.new(current_user)
    Power.current.users
  end
end
