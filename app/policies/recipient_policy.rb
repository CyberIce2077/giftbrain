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
    user
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    exists? && record.editable?
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
