class TasksController < ApplicationController
    before_action :set_task, only: [ :show, :edit, :update, :destroy ] 
  
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    #@task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path
      flash[:notice] = t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

 
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private

    #def set_task
      #@task = Task.find(params[:id])
    #end

    def task_params
      params.require(:task).permit(:title, :content)
    end
end
