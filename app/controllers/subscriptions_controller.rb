class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new()
    @plans = Plan.all
  end

  # POST /subscriptions
  def create
    @subscription = end_of_association_chain.new(params[:subscription])
    @subscription.user_id = current_user.id

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to root_path, notice: 'Subscription was successfully created.' }
      else
        format.html { render action: "new" }
      end
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
