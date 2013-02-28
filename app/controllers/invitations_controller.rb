class InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!


  def new
    build_resource
    render :new
  end


  def update
    puts resource_params.inspect
    if false #resource_params[:name].nil? or resource_params[:name].empty?
      resource.errors.set(:name, "must be set")
      respond_with_navigational(resource) { render :edit }
    else
      self.resource = resource_class.accept_invitation!(resource_params)

      if resource.errors.empty?
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message
        sign_in(resource_name, resource)
        respond_with resource, :location => after_accept_path_for(resource)
      else
        respond_with_navigational(resource){ render :edit }
      end
    end
  end


end