require 'spec_helper'

describe Share do
  let(:album) { FactoryGirl.create(:album) }
  let(:viewer) { FactoryGirl.create(:user) }

  let(:share) {album.shares.build(user_id: viewer.id)}

  it "should not allow access to album_id" do
    expect do
      Share.new(album_id: album.id)
    end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end



end
