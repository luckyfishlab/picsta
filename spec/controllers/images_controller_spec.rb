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


      #FactoryGirl.create(:image)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "should find the image" do
      image = mock_model(Image).as_null_object

      Image.stub(:find).with(image.id.to_s).and_return(image)
      image.should_receive(:destroy).and_return(true)


      delete :destroy, :id => image

    end
    it "redirects to the Album's index" do
      image = mock_model(Image).as_null_object
      album = mock_model(Album).as_null_object

      Image.stub(:find).with(image.id.to_s).and_return(image)
      Image.stub(:destroy).and_return(true)

      delete :destroy, :id=> image
      response.should redirect_to(images_path)
    end

    it "sets a flash[:notice] message" do
      image = mock_model(Image).as_null_object
      album = mock_model(Album).as_null_object

      Image.stub(:find).with(image.id.to_s).and_return(image)
      Image.stub(:destroy).and_return(true)

      delete :destroy, :id=> image
      flash[:notice].should eq("The image was successfully removed.")
    end


  end
end
