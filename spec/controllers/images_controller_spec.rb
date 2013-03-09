require 'spec_helper'

describe ImagesController do
  describe "POST create" do
    let(:image) { mock_model(Image).as_null_object }
    before do
      Image.stub(:new).and_return(image)

      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "creates a new image" do
      Image.should_receive(:new).
          with("title" =>"my image").
          and_return(image)

      post :create, :image => { "title" => "my image" }
    end
    context "when the image save successfully" do
      before do
        image.stub(:save).and_return(true)

      end

      it "sets a flash[:notice] message" do
        post :create
        flash[:notice].should eq("The image was saved successfully.")
      end

      it "redirects to the Album's index" do
        post :create
        response.should redirect_to("/images/#{assigns(:image).id}")
      end
    end

    context "when the image fails to save" do
      before do
        image.stub(:save).and_return(false)
      end

      it "assigns @image" do

        post :create
        assigns[:image].should eq(image)
      end

      it "renders the new template" do

        post :create
        response.should render_template("new")
      end
    end
  end
  describe "DELETE destroy" do

    before do
      @user = FactoryGirl.create(:user)
      sign_in @user

      @album = FactoryGirl.create(:album)
      @image = FactoryGirl.create(:image)
    end
    it "redirects to the Album's index" do

      delete :destroy, :id=> @image
      response.should redirect_to(album_path)
    end

  end
  describe "GET index" do
    before(:each) do
      @user = FactoryGirl.create(:viewer)
      @admin = FactoryGirl.create(:admin)
    end

    def valid_session
        {"warden.user.user.key" => session["warden.user.user.key"]}
    end

    it "should fail when not logged in" do
      get :index, {}
      response.should be_redirect
    end

    it "should fail when a user" do
      sign_in @user
      get :index, {}, valid_session
      response.should be_redirect
    end

    it "should fail when an admin"  do
      sign_in @admin
      get :index, {}, valid_session
      response.should be_redirect
    end
  end
end
