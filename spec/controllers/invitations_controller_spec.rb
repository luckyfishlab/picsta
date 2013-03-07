require 'spec_helper'

describe InvitationsController do

  before (:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:controller_test_subscriber)
    sign_in @user

  end

  def valid_attributes
    { "email" => "friend@example.com" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlbumsController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end


  describe "GET new" do
    it "returns http success" do
      get :new, {}, valid_session
      response.should be_success
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end



  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "assigns the group_id from the paid_subscriber" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(User.last.invited_by_group_id).should eq(@user.invited_by_group_id)
      end

    #
    #  it "redirects to the created album" do
    #    post :create, {:album => valid_attributes}, valid_session
    #    response.should redirect_to(Album.last)
    #  end
    #end
    #
    #describe "with invalid params" do
    #  it "assigns a newly created but unsaved album as @album" do
    #    # Trigger the behavior that occurs when invalid params are submitted
    #    Album.any_instance.stub(:save).and_return(false)
    #    post :create, {:album => { "title" => "invalid value" }}, valid_session
    #    assigns(:album).should be_a_new(Album)
    #  end
    #
    #  it "re-renders the 'new' template" do
    #    # Trigger the behavior that occurs when invalid params are submitted
    #    Album.any_instance.stub(:save).and_return(false)
    #    post :create, {:album => { "title" => "invalid value" }}, valid_session
    #    response.should render_template("new")
    #  end
    end
  end

end