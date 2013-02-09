module ImagesHelper
  def images_toolbar_helper(record)
    ret_text = ''
    album = record.album
    if Power.current.albums.include?(album)
      ret_text << "#{link_to "Remove", @image, :confirm => 'Are you sure?', :method => :delete} | "
    end
    ret_text.html_safe
  end

end

