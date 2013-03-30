# Responsible for determining when and who to send album update notifications
# It is meant to be started from a rake task in the running context.
class NotificationManager

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
          album_stat = {:album_id=>album.id, :title=>album.title, :new_image_count=>current_image_count, :group_id => album.folder.group_id}
          if current_image_count > last_image_count
            album_stat[:delta] = (current_image_count - last_image_count)
          end
          albums_list << album_stat
        end
      end

    end
    albums_list
  end

  def create_updated_groups_list (album_list)
    updated_groups = {}
    album_list.each do |album_h|
         group_id = album_h[:group_id]
        if updated_groups[group_id].nil?
          updated_groups[group_id] = [album_h]
        else
          updated_groups[group_id] << album_h
        end
    end
    updated_groups
  end

  def create_mail_list (updated_groups)
    undelivered_email_list = []
    updated_groups.each_pair do |group_id, album_list|
      Group.find(group_id).users.each do |user|
        undelivered_email_list << GroupNotifier.group_updated(user.id, group_id, album_list)
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
    group_list = create_updated_groups_list updated_albums
    undelivered_email = create_mail_list(group_list)
    pp group_list
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
