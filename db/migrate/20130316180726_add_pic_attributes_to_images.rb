class AddPicAttributesToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_size, :integer
    Image.all.each do |image|
      image.update_pic_attributes
      image.save!
    end
  end
end
