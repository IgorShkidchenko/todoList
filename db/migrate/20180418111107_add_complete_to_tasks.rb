# frozen_string_literal: true

class AddCompleteToTasks < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :tasks, :complete, :boolean, default: false
  end
end
