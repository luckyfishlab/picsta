require 'spec_helper'

describe AlbumStat do
  it "should be created when an album is created" do
    expect {
         album = FactoryGirl.create(:album)

       }.to change(AlbumStat, :count).by(1)

  end

  it "should be destroyed when an album is destroyed" do
    album = FactoryGirl.create(:album)
    expect {
       album.destroy
    }.to change(AlbumStat, :count).by(-1)
 end

end
