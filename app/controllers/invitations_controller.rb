class InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!


  def new
    Power.current = Power.new(current_user)
    if Power.current.is_admin
      build_resource
      render :new
    else
      flash[:notice] = "Invitations are closed at this time."
      redirect_to root_path
    end
  end

end