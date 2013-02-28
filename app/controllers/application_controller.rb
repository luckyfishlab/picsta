class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Consul::Controller
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :access_denied

  current_power do
    Power.new(current_user)
  end


  protected

  def access_denied
    flash[:error] = "Record is not available. You may not have sufficient permission."
    redirect_to "/"
  end

end



