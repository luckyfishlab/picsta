require 'pp'
require 'notification_manager'

NotificationManager.migrate

nm = NotificationManager.new()

nm.process

