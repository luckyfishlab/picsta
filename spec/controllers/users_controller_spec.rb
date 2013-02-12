require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = FactoryGirl.create(:user3)
    @admin = FactoryGirl.create(:user4)

  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlbumsController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end

  describe "GET index" do
     it "fail when not logged in" do
       get :index, {}
       response.should be_redirect
     end

     it "fail for non-admin users" do
       sign_in @user
       get :index, {}
       response.should be_redirect #redirect_to  :controller => 'home', :action => 'index'
     end

     it "should be successful for an admin" do
       sign_in @admin
       get :index, {}, valid_session
       response.should be_success

     end
  end

  describe "GET 'show'" do
    it "should not be successful" do
      get :show, :id => @user.id
      response.should be_redirect
    end

  end

end
