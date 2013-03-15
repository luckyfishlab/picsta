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
    @subscription = end_of_association_chain.find(params[:id])
    @plans = Plan.all
    # Needed so we can set the default selection in the view
    params[:plan_id] = @subscription.plan_id
    @user = current_user

  end

  def update
    @subscription = end_of_association_chain.find(params[:id])
    respond_to do |format|
      if true #@subscription.update_attributes(params[:album])
        format.html { redirect_to edit_registration_path(current_user), notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_plan
    @subscription = end_of_association_chain.find(params[:subscription][:id])
    plan = Plan.find(params[:subscription][:plan_id]) unless params[:subscription][:plan_id].nil?
    if @subscription.update_plan(plan)
      redirect_to edit_registration_path(current_user), :notice => 'Updated plan.'
    else
      redirect_to edit_registration_path(current_user), :notice => 'Unable to update plan.'
    end
  end

  def update_card
    @subscription = end_of_association_chain.find(params[:subscription][:id])
    stripe_token = params[:subscription][:stripe_token]
    if !stripe_token.empty? and @subscription.update_card(stripe_token)
      redirect_to edit_registration_path(current_user), :notice => 'Updated card.'
    else
      redirect_to edit_registration_path(current_user), :notice => 'Unable to update card.'
    end
  end


  def end_of_association_chain
    Subscription
  end
end
