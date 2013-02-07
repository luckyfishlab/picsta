class SharesController < ApplicationController
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

end