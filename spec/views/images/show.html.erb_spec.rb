require 'spec_helper'

describe "images/show.html.erb" do
  it "should show the title of the image" do
    assign(:image, mock_model("Image",  :title => "testimage.jpg").as_null_object)
    render
    rendered.should have_content("testimage.jpg")
  end

  it "should have a link to remove the image" do
    assign(:image, mock_model("Image",  :title => "testimage.jpg").as_null_object)
    render
    rendered.should have_content("Remove")
  end

end