class TasksController < InheritedResources::Base

  def update_status
    @task = Task.find_by(id: params[:task_id])
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private
    def set_task
      @task = Task.find(params[:task_id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :status)
    end

end
