class StaticPagesController < ApplicationController
  before_filter  :authenticate_user!, :only => :thanks

  def home
    render :layout => 'home'
  end

  def about
  end

  def privacy
  end

  def thanks

  end
end
