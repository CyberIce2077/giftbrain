class RecipientIdeaPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end

  def destroy?
    true
  end

  def reorder?
    true
  end
end
