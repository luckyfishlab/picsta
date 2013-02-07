require 'spec_helper'

describe '/shares/new.html.erb' do
  let (:share) do
    mock_model("Share").as_new_record.as_null_object
  end
  before do
    assign(:share, share)
  end

  it "renders a form to share an album" do
    render
    render.should have_selector("form input[@type='submit']")
  end
  it "renders a drop-down to select a user" do
    render
    #render.should have_selector("form input[@type='selector']")
    render.should have_select("User")
  end
  #it "renders a text field to enter and email address" do
  #  render
  #  render.should have_field("email")
  #end
end


