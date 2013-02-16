require "spec_helper"
require 'pp'
describe AlbumNotifier do
  it "should send the user an email" do
    user = FactoryGirl.create(:user)
    AlbumNotifier.welcome_email(user).deliver
    pp sent
  end

  it "should send an album updated email" do
    user = FactoryGirl.create(:user)
    album = FactoryGirl.create(:album)
    AlbumNotifier.album_updated(album.id, user.id).deliver

    pp sent.first
    puts sent.first.body
  end



  def sent
    ActionMailer::Base.deliveries
  end
end
