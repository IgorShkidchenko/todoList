# frozen_string_literal: true

class Ability # :nodoc:
  include CanCan::Ability
  def initialize(user)
    if user.present?
      can :manage, Project, user_id: user.id
      if user.projects.count.positive?
        can :manage, Task, project_id: user.projects.all.ids
      end
    end
  end
end
