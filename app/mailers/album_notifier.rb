class AlbumNotifier < ActionMailer::Base

  def welcome_email(user)
    @from = "from@example.com"
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :from => @from, :subject => "Welcome to My Awesome Site")
  end

  def album_updated(user_id, album_id)
    @from = "news@picsta.co"
    @user = User.find(user_id)
    @album = Album.find(album_id)

    mail(:to =>@user.email, :from => @from, :subject => "New pictures were added")
    headers['X-MC-GoogleAnalytics'] = "picsta.co"
    headers['X-MC-Tags'] = "album_update"
  end
end
