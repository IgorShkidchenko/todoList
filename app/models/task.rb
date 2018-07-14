# frozen_string_literal: true

class Task < ApplicationRecord # :nodoc:
  belongs_to :project
  acts_as_list scope: :project
  validates :content, presence: true
end
