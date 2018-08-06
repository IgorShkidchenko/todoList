# frozen_string_literal: true

class AddDeadlineToTasks < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :tasks, :deadline, :date
  end
end
