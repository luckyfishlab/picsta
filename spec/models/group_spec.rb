require 'spec_helper'

describe Group do
  it "should be created when a paid_subscriber signs up" do

    expect {
      user = FactoryGirl.create(:paid_subscriber)

    }.to change(Group, :count).by(1)

  end

  it "should have owner initialized to the paid subscriber" do
  user = FactoryGirl.create(:paid_subscriber)
  expect(Group.last.owner_id).to eq(user.id)
  end
end
