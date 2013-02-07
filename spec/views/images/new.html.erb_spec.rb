require 'spec_helper'

describe "images/new.html.erb" do
  let (:image) do
    mock_model("Image").as_new_record.as_null_object
  end
  before do
    assign(:image, image)
  end
  it "renders a form to add an image" do
    render
    rendered.should have_selector("form input[@type='submit']")
  end
  it "renders a text field for an image title" do
    image.stub(:title => "The Image Title")
    render
    rendered.should have_selector("form input[@value='The Image Title']")

  end

end