class RegistrationsController < Devise::RegistrationsController


  def after_sign_up_path_for(resource)
    #'/thanks'
    new_subscription_path
  end

end