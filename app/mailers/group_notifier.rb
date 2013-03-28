class GroupNotifier < ActionMailer::Base

  def welcome_email(user)
    @from = "from@example.com"
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :from => @from, :subject => "Welcome to My Awesome Site")
  end

  def group_updated(user_id, group_id, updated_albums)
    @from = "news@picsta.co"
    @user = User.find(user_id)
    @group = Group.find(group_id)
    @updated_albums = updated_albums

    mail(:to =>@user.email, :from => @from, :subject => "New pictures were added")
    headers['X-MC-GoogleAnalytics'] = "picsta.co"
    headers['X-MC-Tags'] = "group_update"
  end
end
