require 'spec_helper'

describe ActivitiesController do

  before (:each) do
    @user = FactoryGirl.create(:subscriber)
    sign_in @user
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlbumsController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end


  describe "GET 'index'" do
    it "returns http success" do
      get 'index', {}, valid_session
      response.should be_success
    end
  end

end
