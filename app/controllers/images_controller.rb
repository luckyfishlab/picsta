class ImagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    flash[:notice] = "Access not available"
    redirect_to root_path
  end

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

    Power.current = Power.new(current_user)

  end

  def new

    @image = Image.new(:album_id => params[:album_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def destroy
    Power.current = Power.new(current_user)
    #Power.current.albums
    
    @image = Image.find(params[:id])
    album = @image.album
    if Power.current.albums.include?(album)
      @image.destroy
      flash[:notice] = "The image was successfully removed."
      redirect_to album
    else
      flash[:notice] = "You don't have permission to delete this image."
      redirect_to @image
    end
      
  end


end
