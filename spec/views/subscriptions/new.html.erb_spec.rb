require 'spec_helper'

describe "subscriptions/new.html.erb" do
  let (:subscription) do
    mock_model("Subscription").as_new_record.as_null_object
  end
  before do
    assign(:subscription, subscription)
    silver = FactoryGirl.create(:plan, {:name => 'silver'})
    gold = FactoryGirl.create(:plan, {:name => 'gold'})
    assign(:plans, [silver, gold])
  end

  it "renders a form to create a subscription" do

    render
    render.should have_selector("form input[@type='submit']")
  end
  it "renders a radio button for the plans" do
    render
    render.should have_selector("form input[type=radio]")
  end

  it "renders the plan contents" do
    render

    render.should have_content("silver")
    render.should have_content("gold")
  end

end