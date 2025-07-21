class RecipientPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(creator: user)
    end
  end

  def index?
    true
  end

  def show?
    scope.exists?(record.id)
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    show? && record.editable?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def generate_ideas?
    edit?
  end
end
