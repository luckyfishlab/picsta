include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    title "MyImage"
    album_id 1
    pic { fixture_file_upload("./spec/fixtures/files/test.jpg","image/jpeg")  }
  end
end