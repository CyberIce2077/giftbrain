class RecipientIdeaPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:recipient).where(recipients: { creator_id: user.id })
    end
  end

  def destroy?
    true
  end

  def reorder?
    true
  end
end
