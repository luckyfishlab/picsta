require 'spec_helper'

describe Subscription do
  describe ".update_stripe" do


    context "with a non-existing user" do

      before do
        successful_stripe_response = StripeHelper::Response.new("success")
        Stripe::Customer.stub(:create).and_return(successful_stripe_response)
        @user = User.new(email: "test@testing.com", name: 'tester', password: 'password')
        @user.subscription.stripe_token = 12345
        @role = FactoryGirl.create(:silver_role)
        @role.build_membership(@user)

      end

      it "creates a new user with a succesful stripe response" do
        @user.save!
        new_user = User.last
        new_user.subscription.customer_id.should eq("youAreSuccessful")
        new_user.subscription.last_4_digits.should eq("4242")
        new_user.subscription.stripe_token.should be_nil
      end

    end
  end
end
