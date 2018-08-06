# frozen_string_literal: true

class Task < ApplicationRecord # :nodoc:
  belongs_to :project
  acts_as_list scope: :project
  validates :content, presence: { message: "can't be blank!" }
  validates :content, length: { maximum: 65, message: 'is too long!' }
  validate :past_deadline

  def past_deadline
    if !deadline.blank? && deadline < Date.today
      errors.add(:Deadline, "can't be in the past!")
    end
  end
end
