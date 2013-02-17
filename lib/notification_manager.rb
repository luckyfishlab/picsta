# Responsible for determining when and who to send album update notifications
# It is meant to be started from a rake task in the running context.
class NotificationManager

  def create_album_subscriber_list (album_list)
    album_list.each do |album_h|
      album_h[:subscribers] = []
      album = Album.find(album_h[:album_id])
      album.shares.each do |share|
        if share.email_notice.nil? or share.email_notice > 0
          # These are the people interested in the album
          album_h[:subscribers] << share.user_id
        end
      end
    end
    album_list
  end

  def create_updated_albums_list
    albums_list = []
    Album.all.each do |album|
      unless album.images.count.nil?
        current_image_count = album.images.count
        last_image_count = 0
        unless album.album_stat.last_image_count.nil?
          last_image_count = album.album_stat.last_image_count
        end

        # check what stats we need to update
        if current_image_count != last_image_count
          album_stat = {:album_id=>album.id, :new_image_count=>current_image_count}
          if current_image_count > last_image_count
            album_stat[:delta] = (current_image_count - last_image_count)
          end
          albums_list << album_stat
        end
      end

    end
    albums_list
  end

  def create_mail_list (albums_list)
    undelivered_email_list = []
    albums_list.each do |album_h|
      album_id = album_h[:album_id]
      album_h[:subscribers].each do |user_id|
        undelivered_email_list << AlbumNotifier.album_updated(user_id, album_id)
      end
    end
    undelivered_email_list
  end


  def update_album_stat_records (updated_albums)
    updated_albums.each do |album_h|
      album = Album.find(album_h[:album_id])
      album.album_stat.last_image_count = album_h[:new_image_count]
      album.album_stat.save!
    end
  end

  def process
    updated_albums = create_updated_albums_list
    updated_albums = create_album_subscriber_list(updated_albums)
    undelivered_email = create_mail_list(updated_albums)
    pp updated_albums
    undelivered_email.each { |email| email.deliver }
    update_album_stat_records(updated_albums)
  end


  def self.migrate
    Album.all.each do |album|
      if album.album_stat.nil?
        album.build_album_stat
      end
      album.save!
    end
  end
end
