# frozen_string_literal: true

class Project < ApplicationRecord # :nodoc:
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  validates :name, presence: { message: "can't be blank!" }
  validates :name, length: { maximum: 60, message: 'is too long!' }
end
