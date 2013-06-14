class PlansController < ApplicationController
  def create
    @plan = current_user.plans.create(params[:plan])

    flash[:notice] = "Plan has been made"
    redirect_to user_plan_path(current_user, @plan)
  end

  def show
   @plan = Plan.find(params[:id])
  end
end
