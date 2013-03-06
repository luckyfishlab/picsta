class InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!


  def new
    build_resource
    render :new
  end


  def update
    self.resource = resource_class.accept_invitation!(resource_params)

    if resource.errors.empty?
      # Add the user to the first group
      # TODO: this should really be linked to the group that
      # was active at the time the invitation was sent
      ## overly optimistic!
      User.find(resource.invited_by_id).groups.first.create_group_user!(resource)

      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

end