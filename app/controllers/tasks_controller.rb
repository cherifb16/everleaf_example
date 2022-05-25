class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(dead_line: :desc).page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc).page(params[:page])
    else
      @tasks = Task.all.order(created_at: :desc).page(params[:page])
    end

    if params[:name].present? && params[:number].present?
      # return search results where both name and status are valid
      @tasks = Task.search_name(params[:name]).search_status(params[:number]).page(params[:page])
      # When the only parameter passed is the task name
    elsif params[:name].present?
      @tasks = Task.search_name(params[:name]).page(params[:page])
      # When the only parameter passed is status
    elsif params[:number].present?
      @tasks = Task.search_status(params[:number]).page(params[:page])
    end
  end


  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :content, :dead_line, :status, :priority)
    end
end
