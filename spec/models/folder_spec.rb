require 'spec_helper'

describe Folder do
  it "should be created when a paid_subscriber signs up" do

    expect {
      user = FactoryGirl.create(:paid_subscriber)

    }.to change(Folder, :count).by(1)

  end
end
