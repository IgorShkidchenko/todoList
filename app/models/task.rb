# frozen_string_literal: true

class Task < ApplicationRecord # :nodoc:
  belongs_to :project
  acts_as_list scope: :project
  validates :content, presence: true
  validate :past_deadline

  def past_deadline
    if !deadline.blank? and deadline < Date.today
      errors.add(:update, '')
    end
  end
end
