class ContactController < ApplicationController
  before_filter :authenticate_user!
  def new
    @current_user = current_user
    @message = Message.new
    @message.name = @current_user.name
    @message.email = @current_user.email
    @message.subject= "Feedback"

  end

  def create
    @current_user = current_user
    @message = Message.new(params[:message])

    # Forcing these back to sane values, just in case
    # TODO: probably not needed
    @message.name = @current_user.name
    @message.email = @current_user.email
    @message.subject= "Feedback"

    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end
