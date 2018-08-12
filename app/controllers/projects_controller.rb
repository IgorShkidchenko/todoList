# frozen_string_literal: true

class ProjectsController < ApplicationController # :nodoc:
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_project, only: %i[edit update destroy]

  respond_to :html, :js

  def new
    @project = Project.new
    respond_with(@project)
  end

  def create
    @project = current_user.projects.build(project_params)
    create_update_actions(@project, 'created', 'new_blank')
  end

  def edit
    respond_with(@project)
  end

  def update
    create_update_actions(@project, 'updated', @project.id)
  end

  def destroy
    destroy_action(@project, 'Project')
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
