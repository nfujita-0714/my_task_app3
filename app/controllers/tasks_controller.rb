class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy]
  before_action :authenticate_user, only: %i[edit update destroy]

  # GET /tasks or /tasks.json
  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(limit_on: :desc).page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(5)
    elsif
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
    end
    
    if params[:search_title].present? && params[:search_status].present?
      @tasks = current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status]).page(params[:page]).per(5)
    elsif params[:search_title].present?
      @tasks = current_user.tasks.search_title(params[:search_title]).page(params[:page]).per(5)
    elsif params[:search_status].present?
      @tasks = current_user.tasks.search_status(params[:search_status]).page(params[:page]).per(5)
    elsif params[:label_id].present?
      @tasks = Task.joins(:labels).where(labels:{id: params[:label_id]}).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
    if @task.save
      redirect_to tasks_path, notice: "登録しました！"
    else
      render :new
    end
  end
end

def confirm
  @task = current_user.tasks.build(task_params)
  render :new if @task.invalid?
end

def edit
end

def show
end

def update
  if @task.update(task_params)
    redirect_to tasks_path, notice: "編集しました！"
  else
    render :edit
  end
end

  def destroy
    @task.destroy
    redirect_to  tasks_path
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content, :user_id, :limit_on, :status, :priority, :user, label_ids:[])
  end
end
