#require 'spec_helper'
#
#describe SubscriptionsController do
#
#  before (:each) do
#    @user = FactoryGirl.create(:user)
#    sign_in @user
#  end
#
#  def valid_attributes
#     { "plan_id" => 1, "user_id" => 1 }
#  end
#
#  def valid_session
#     {"warden.user.user.key" => session["warden.user.user.key"]}
#  end
#
#  describe "GET 'new'" do
#    it "returns http success" do
#      get 'new'
#      response.should be_success
#    end
#    it "assigns a new subscription as @subscription" do
#       get :new, {}, valid_session
#       assigns(:subscription).should be_a_new(Subscription)
#     end
#  end
#
#  describe "POST create" do
#    describe "with valid params" do
#      it "creates a new Subscription" do
#        expect {
#          post :create, {:subscription => valid_attributes}, valid_session
#        }.to change(Subscription, :count).by(1)
#      end
#
#      it "assigns a newly created subscription as @subscription" do
#        post :create, {:subscription => valid_attributes}, valid_session
#        assigns(:subscription).should be_a(Subscription)
#        assigns(:subscription).should be_persisted
#      end
#
#      it "redirects to the root" do
#        post :create, {:subscription => valid_attributes}, valid_session
#        response.should redirect_to root_path
#      end
#    end
#
#    ## TODO more subscription controller actions and test cases
#    #describe "with invalid params" do
#    #  it "assigns a newly created but unsaved album as @album" do
#    #    # Trigger the behavior that occurs when invalid params are submitted
#    #    Album.any_instance.stub(:save).and_return(false)
#    #    post :create, {:album => { "title" => "invalid value" }}, valid_session
#    #    assigns(:album).should be_a_new(Album)
#    #  end
#    #
#    #  it "re-renders the 'new' template" do
#    #    # Trigger the behavior that occurs when invalid params are submitted
#    #    Album.any_instance.stub(:save).and_return(false)
#    #    post :create, {:album => { "title" => "invalid value" }}, valid_session
#    #    response.should render_template("new")
#    #  end
#    #end
#  end
#
#  #describe "GET 'edit'" do
#  #  it "returns http success" do
#  #    get 'edit'
#  #    response.should be_success
#  #  end
#  #end
#
#end
