require 'pp'
require 'notification_manager'

NotificationManager.migrate

nm = NotificationManager.new()

updated_albums = nm.create_updated_albums_list
updated_albums = nm.create_mail_list(updated_albums)
#nm.update_album_stat_records(updated_albums)
pp updated_albums