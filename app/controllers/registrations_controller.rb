class RegistrationsController < Devise::RegistrationsController
  def new
    @plan = params[:plan]
    if @plan.eql?('silver')
      super
    else
      params[:plan] = 'silver'
      @plan = params[:plan]
      super
      #redirect_to root_path, :notice => 'Please select a subscription plan below.'
    end
  end


  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      #respond_with resource
      #render :new
      redirect_to new_user_registration_path, :notice => 'declined'
    end
  end

  def update_plan
    @user = current_user
    #role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    if false #@user.update_plan(role)
      redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    else
      flash.alert = 'Unable to update plan.'
      render :edit
    end
  end

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end

  private
  def build_resource(*args)
    super
    if params[:plan]
      ## This is 'rolify'
      #resource.add_role(params[:plan])
      resource.memberships << Role.find_by_name(params[:plan]).build_membership(resource)

    end
  end
end