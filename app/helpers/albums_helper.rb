module AlbumsHelper
  def toolbar_helper(record)
    ret_text = ''
    if Power.current.updatable_albums?(record)
      ret_text << "#{link_to 'Add Images', new_image_path(:album_id => record)}"
      ret_text << " | #{link_to 'Edit', [:edit, record]} | "
      #ret_text << " | #{link_to 'Share Album', new_album_shares_path(record)} | "
      ret_text.html_safe
    end
  end

end
