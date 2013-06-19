class PlansController < ApplicationController
  def create
    @plan = current_user.plans.create(params[:plan])

    if @plan.save
      flash[:notice] = "Plan has been made"
      redirect_to user_plan_path(current_user, @plan)
    else
      flash[:error] = "Invalid name"
      redirect_to :back
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @plan_entries = @plan.plan_entries
  end

  def destroy
    @plan = Plan.find(params[:id])
    flash[:notice] = "Plan #{@plan.name} is removed"
    @plan.destroy
    redirect_to user_path(current_user)
  end
end
