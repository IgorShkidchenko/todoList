# frozen_string_literal: true

class ProjectsController < ApplicationController # :nodoc:
  
  before_action :set_project, only: %i[edit update destroy]

  respond_to :html, :js

  def new
    @project = Project.new
    respond_with(@project)
  end
  
  def create
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        flash.now[:success] = 'Project created!'
        format.js {}
      else
        flash.now[:danger] = "Can't be blank!"
        format.js { render :valid }
      end
    end
  end

  def edit
    respond_with(@project)
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        flash.now[:success] = 'Project updated!'
        format.js {}
      else
        flash.now[:danger] = "Can't be blank!"
        format.js { render :valid }
      end
    end
  end

  def destroy
    @project.destroy
    flash.now[:danger] = 'Project deleted!'
  end

  def valid
    respond_with(@project)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end