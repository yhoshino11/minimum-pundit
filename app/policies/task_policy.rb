class TaskPolicy
  attr_reader :current_user, :task

  def initialize(current_user, task)
    @user = current_user
    @task = task
  end

  def owner?
    @task.user == @user
  end
end
