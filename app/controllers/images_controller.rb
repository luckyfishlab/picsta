class ImagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    flash[:notice] = "Access not available"
    redirect_to root_path
  end

  def create
    @image = end_of_association_chain.new(params[:image])
    if @image.save
      @image.create_activity :create, owner: current_user

      flash[:notice] = "The image was saved successfully."
      redirect_to @image.album
    else
      render :action => "new"
    end
  end

  def show
    @image = end_of_association_chain.find(params[:id])
  end

  def new
    @image = end_of_association_chain.new(:album_id => params[:album_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def destroy
    @image = end_of_association_chain.find(params[:id])
    album = @image.album
    @image.create_activity :destroy, owner: current_user

    @image.destroy

    flash[:notice] = "The image was successfully removed."
    redirect_to album

  end

  def end_of_association_chain
    Power.current = Power.new(current_user)
    Power.current.images
  end

end
