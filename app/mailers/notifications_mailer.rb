class NotificationsMailer < ActionMailer::Base

  default :from => "dana@picsta.co"
  default :to => "dana@picsta.co"

  def new_message(message)
    @message = message
    mail(:subject => "PICSTA.CO #{message.subject}")
    headers['X-MC-GoogleAnalytics'] = "picsta.co"
    headers['X-MC-Tags'] = "feedback"
  end

end