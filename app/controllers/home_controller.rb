class HomeController < ApplicationController
  def index
    unless current_user.nil?
      if current_user.name.nil?
        flash[:notice] = "Take a minute to add your name. Click Edit account in the top menu bar"
      end
    end
  end
end
