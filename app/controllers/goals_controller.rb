class GoalsController < ApplicationController
  def index
    @goals = Goal.find_by_user_id(params[:user_id])
    redirect_to user_url(params[:user_id])
  end

  def show

  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    #@goal.user_id = current_user.id
    if @goal.save
      redirect_to user_url(@goal.user_id)
    else
      flash[:errors] = @goal.errors.full_messages + [current_user.id]
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  private

  def goal_params
    params.require(:goal).permit(:goal_name)
  end
end
