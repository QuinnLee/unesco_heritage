class PlansController < ApplicationController
  def create
    @plan = current_user.plans.create(params[:plan])

    if @plan.save
      flash[:notice] = "Plan has been made"
      redirect_to plan_path( @plan)
    else
      flash[:error] = "Invalid name"
      redirect_to :back
    end
  end

  def show
    @plan = current_user.plans.find(params[:id])
    @plan_entries = @plan.plan_entries
    cartographer = Cartographer.new(plan: @plan, user: current_user)
    @polyline = cartographer.polylines
    @json = cartographer.markers
  end

  def destroy
    @plan = current_user.plans.find(params[:id])
    flash[:notice] = "Plan #{@plan.name} is removed"
    @plan.destroy
    redirect_to user_path(current_user)
  end
end
