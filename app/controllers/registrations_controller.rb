class RegistrationsController < Devise::RegistrationsController

  def new
    flash[:info] = 'Registration is not open yet, but please check back soon'
    redirect_to root_path
  end

  def create
    flash[:info] = 'Registration is not open yet, but please check back soon'
    redirect_to root_path
  end

end