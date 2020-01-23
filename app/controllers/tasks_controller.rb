class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /tasks
  def index
    if logged_in?
      @tasks = Task.all.page(params[:page]).per(6)
      if params[:sort_expired]
         @tasks = Task.all.page(params[:page]).per(6).asc_end_on
      elsif params[:sort_importance]
        @tasks = Task.all.page(params[:page]).per(6).desc_importance
      elsif params[:search] && params[:title].blank? && params[:status].blank?
        puts "両方空だよ"
      elsif params[:search] && params[:title].blank?
         puts "タイトルが空だよ"
        @tasks = Task.page(params[:page]).per(6).where_like_status(params[:status])
      elsif params[:search] && params[:status].blank?
         puts "ステータスが空だよ"
        @tasks = Task.page(params[:page]).per(6).where_like_title(params[:title])
      elsif params[:search]
         puts "両方で検索"
        @tasks = Task.page(params[:page]).per(6).where_like_status_title(params[:title],params[:status])
      else
        @tasks = Task.all.page(params[:page]).per(6).desc_created
      end
    else
      redirect_to new_session_path , notice: 'loginしてください。'
    end

  end

  # GET /tasks/
  def show
    if logged_in?
        @task = Task.find(params[:id])
    else
        redirect_to new_session_path , notice: 'loginしてください。'
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    if logged_in?
        @task = Task.find(params[:id])
    else
        redirect_to new_session_path , notice: 'loginしてください。'
    end
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :content, :end_on, :status, :search, :importance, label_ids: [])
    end

    def correct_user
      task = Task.find(params[:id])
      if current_user.id != task.user.id
        redirect_to new_session_path , notice: 'loginしてください。'
      end
    end
end
