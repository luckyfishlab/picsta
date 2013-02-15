require 'pp'

class SharesController < ApplicationController
  before_filter :authenticate_user!
  def create
    @album = Album.find(params[:share][:album_id])
    @user = User.find(params[:share][:user_id])
    @album.create_share!(@user)

    redirect_to @album
  end

  def new

     @share = Share.new()
     @share.album_id = params[:album_id]

     respond_to do |format|
       format.html # new.html.erb
     end
  end

  def update
    @share = Share.find(params[:id])
    if @share.user_id.eql?(current_user.id)
      if params[:share][:email_notice].eql?("1")
        @share.email_notice = 1
      else
        @share.email_notice = 0
      end
      @share.save!
      redirect_to albums_path, :notice => "Saved"
    else
      redirect_to albums_path, :alert => "Access not available"
    end

  end

end