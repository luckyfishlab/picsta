module ImagesHelper

  def images_navigation_toolbar(image)

    ret_text = ''
    prev_image = image.previous
    next_image = image.next

    if prev_image
      ret_text << "#{link_to 'Previous', image_path(prev_image)}"
      if next_image
        ret_text << " | "
      end
    end
    if next_image
      ret_text << "#{link_to 'Next', image_path(next_image)}"
    end
    ret_text.html_safe

  end

  def images_toolbar_helper(record)
    ret_text = ''
    album = record.album
    if Power.current.albums.include?(album)
      ret_text << "#{link_to "Remove", @image, :confirm => 'Are you sure?', :method => :delete} | "
    end
    ret_text.html_safe
  end

end

