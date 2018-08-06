# frozen_string_literal: true

class AddPositionToTasks < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :tasks, :position, :integer
  end
end
