class InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!


  def new
    build_resource
    render :new
  end

end