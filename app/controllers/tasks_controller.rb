# frozen_string_literal: true

class TasksController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, except: %i[new create]
  
  respond_to :html, :js

  def new
    @task = Task.new
    respond_with(@task)
  end

  def create
    @task = @project.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        flash.now[:success] = 'Task created!'
        format.js {}
      else
        flash.now[:danger] = @task.errors.full_messages.to_sentence
        format.js { render :valid }
      end
    end
  end

  def edit
    respond_with(@task)
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        flash.now[:success] = 'Task updated!'
        format.js {}
      else
        flash.now[:danger] = @task.errors.full_messages.to_sentence
        format.js { render :valid }
      end
    end
  end

  def destroy
    @task.destroy
    flash.now[:danger] = 'Task deleted!'
    respond_with(@task)
  end

  def complete
    @task.update_attribute(:complete, true)
    flash.now[:info] = 'Task completed!'
    respond_with(@task)
  end

  def sort_up 
    @task.move_higher
  end

  def sort_down
    @task.move_lower
  end

  def valid
    respond_with(@task)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_task
    @task = current_user.projects.find(params[:project_id]).tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :deadline)
  end
end
