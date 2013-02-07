require 'spec_helper'

describe SharesController do

# This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlbumsController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end


describe "POST create" do
  it "create a new share" do
    user = FactoryGirl.create(:user)
    sign_in user
    album = FactoryGirl.create(:album)

    expect {
      post :create,  {:share => {"album_id" => 1, "user_id" => 1}}, valid_session
    }.to change(Share, :count).by(1)

  end

end

describe ""

end