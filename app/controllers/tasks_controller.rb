class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

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
    end
  end
  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "登録しました！"
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "タスクが更新されました！" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクが削除されました！" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :user_id, :limit_on, :status, :priority)
    end
end
