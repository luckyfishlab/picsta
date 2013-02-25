class HomeController < ApplicationController
  def index
    unless current_user.nil?
      if current_user.name.nil?
        flash[:notice] = "Take a minute to add your name. Click Edit account in the top menu bar"
      end
    end
    if user_signed_in?
      #@activities = PublicActivity::Activity.order("created_at desc")
      all_activities = PublicActivity::Activity.order("created_at desc")
      @activities = Kaminari.paginate_array(all_activities).page(params[:page])
    end
  end
end
