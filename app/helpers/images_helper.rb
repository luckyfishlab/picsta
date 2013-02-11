module ImagesHelper

  def images_navigation_toolbar(image)

=begin
    <ul class="pager">
    <li class="previous">
    <a href="#">&larr; Older</a>
    </li>
    <li class="next">
    <a href="#">Newer &rarr;</a>
    </li>
    </ul>
=end


    ret_text = '<ul class="pager">'
    prev_image = image.previous
    next_image = image.next

    ret_text << '<li class="previous '
    if prev_image.nil?
      ret_text << 'disabled">'
    else
          ret_text << '">'
    end
    if prev_image
    ret_text << "#{link_to 'Previous', image_path(prev_image)}"
    else
      ret_text << "#{link_to 'Previous', '#'}"
    end
    ret_text << '</li>'

    ret_text << '<li class="next '
    if next_image.nil?
      ret_text << 'disabled">'
    else
      ret_text << '">'
    end
    if next_image
      ret_text << "#{link_to 'Next', image_path(next_image)}"
    else
      ret_text << "#{link_to 'Next', '#'}"

    end

    ret_text << '</li>'
    ret_text << '</ul>'
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

