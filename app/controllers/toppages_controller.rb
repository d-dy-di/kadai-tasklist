class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @taskss = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
end
