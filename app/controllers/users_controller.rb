class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = current_user
    @plan = @user.plans.build
    @plans = users_plans.page params[:page]
  end

  private
  def users_plans
    Plan.users_plan(@user)
  end
end
