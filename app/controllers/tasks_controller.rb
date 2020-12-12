class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  
  def index
      @task = current_user.tasks.build  
      @tasks = current_user.tasks.all
  end

  def show
    @task = Task.find(params[:id])
    @tasks = current_user.tasks.all
  end

  def new
    @task = Task.new
    @tasks = current_user.tasks.all
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end



  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
    
    @tasks = current_user.tasks.all
  end

  def destroy

    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
    
    @tasks = current_user.tasks.all

  end
  
  private
  

  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
