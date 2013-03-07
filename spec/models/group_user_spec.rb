require 'spec_helper'

describe GroupUser do
  it "should be created when a paid_subscriber signs up" do

    expect {
      user = FactoryGirl.create(:paid_subscriber)

    }.to change(GroupUser, :count).by(1)

  end
end
