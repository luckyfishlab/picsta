class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new()
    @plans = Plan.all
    # Needed so we can set the default selection in the view
    params[:plan_id] = @plans.first.id
    @user = current_user
  end

  # POST /subscriptions
  def create
    @subscription = end_of_association_chain.new(params[:subscription])
    @subscription.user_id = current_user.id

    if @subscription.save_with_payment
      redirect_to root_path, :notice => "Thank you for subscribing!"
    else
      @user = current_user
      render :new
    end
  end

  def edit
  end

  def update
  end

  def end_of_association_chain
    Subscription
  end
end
