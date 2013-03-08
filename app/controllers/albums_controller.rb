class AlbumsController < ApplicationController
  before_filter :authenticate_user!

  # GET /albums
  # GET /albums.json
  def index
    @albums = end_of_association_chain.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = end_of_association_chain.find(params[:id])
    if @album
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @album }
      end
    else
      redirect_to albums_path, notice: "Insufficient permission to access the requested album"
    end

  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = end_of_association_chain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end

  end

  # GET /albums/1/edit
  def edit
    @album = end_of_association_chain.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = end_of_association_chain.new(params[:album])
    @album.user_id = current_user.id
    group_id = Power.current.current_group.id
    @album.folder_id = Folder.find_by_group_id(group_id).id

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end


  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = end_of_association_chain.find(params[:id])
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = end_of_association_chain.find(params[:id])
    @album.destroy


    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end

  def end_of_association_chain
    current_power.albums
  end

end
