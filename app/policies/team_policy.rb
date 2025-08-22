class TeamPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def index?
    user
  end

  def show?
    true
  end

  def new?
    !exists?
  end

  def create?
    new?
  end

  def edit?
    exists?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
