class TasksController < ApplicationController
  before_action :correct_user_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
    @tasks = @tasks.default_order.page(params[:page])
    sort_task
    search_task
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id #@taskにcurrent_user.idを入れないとuserがないとエラーが出てしまう。
    if @task.save
      flash[:primary] = t('.Task was successfully created')
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = t('.Task was successfully updated')
      redirect_to tasks_path
    else
      render :edit
    end
  end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      flash[:danger] = t('.Task was successfully destroyed')
      redirect_to tasks_path
    end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, { label_ids: []})
  end

  def correct_user_task
    @task = Task.find(params[:id])
    user = User.find(@task.user_id)
    return if user_admin?
    redirect_to tasks_path, flash: {warning: "本人以外アクセスできません"} unless current_user?(user)
  end
end