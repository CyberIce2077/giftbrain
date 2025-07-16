class IdeaPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:recipients).where(recipients: { creator_id: user.id })
    end
  end
end
