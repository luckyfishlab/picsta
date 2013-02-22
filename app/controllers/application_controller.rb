class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :access_denied

  protected

  def access_denied
    flash[:error] = "Record is not available. You may not have sufficient permission."
    redirect_to "/"
  end

end
