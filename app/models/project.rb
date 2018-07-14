# frozen_string_literal: true

class Project < ApplicationRecord # :nodoc:
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  validates :name, presence: true
end
