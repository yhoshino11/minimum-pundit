class TasksController < ApplicationController
  def index
    @tasks = User.find(params[:user_id]).tasks.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.new
    authorize @task, :owner?
  end

  def create
    @task = current_user.tasks.new(task_params)
    authorize @task, :owner?
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    authorize @task, :owner?
  end

  def update
    @task = Task.find(params[:id])
    authorize @task, :owner?
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    authorize @task, :owner?
    @task.destroy
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :public)
  end
end
