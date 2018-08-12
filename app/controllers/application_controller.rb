# frozen_string_literal: true

class ApplicationController < ActionController::Base # :nodoc:
  protect_from_forgery with: :exception
  
  def create_update_actions(controller, flash_message, local = '')
    respond_to do |format|
      if controller == @project
        if controller.update(project_params) || controller.save
          flash.now[:success] = "Project #{flash_message}!"
          format.js {}
        else
          flash.now[:danger] = controller.errors.full_messages.to_sentence
          format.js { render :valid, locals: { flash_div: ".flash.#{local}" } }
        end
      else
        if controller.update(task_params) || controller.save
          flash.now[:success] = "Task #{flash_message}!"
          format.js {}
        else
          flash.now[:danger] = controller.errors.full_messages.to_sentence
          format.js { render :valid }
        end
      end
    end
  end

  def destroy_action(controller, flash_message)
    controller.destroy
    flash.now[:danger] = "#{flash_message} deleted!"
    respond_with(controller)
  end
end
