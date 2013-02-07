class ImagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "The image was saved successfully."
      redirect_to @image.album
    else
      render :action => "new"
    end
  end
  def show
    @image = Image.find(params[:id])
  end
  def new

    @image = Image.new(:album_id => params[:album_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def destroy

    @image = Image.find(params[:id])
    album = @image.album
    @image.destroy
    flash[:notice] = "The image was successfully removed."
    redirect_to album
  end
end