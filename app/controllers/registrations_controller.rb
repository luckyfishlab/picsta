class RegistrationsController < Devise::RegistrationsController
  def new
    @plan = params[:plan]
    if @plan.eql?('silver')
      super
    else
      redirect_to root_path, :notice => 'Please select a subscription plan below.'
    end
  end


  def create
     puts params
     super
     #@subscription = Subscription.new(params[:subscription_attributes])
     #if @subscription.save_with_payment
     #  redirect_to @subscription, :notice => "Thank you for &crarr;
     #    subscribing!"
     #else
     #  render :new
     #end
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