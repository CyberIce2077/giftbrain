class TeamPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:team_members).where(team_members: { user: })
    end
  end

  def index?
    user
  end

  def show?
    user == record.recipient.creator && exists?
  end

  def new?
    !exists?
  end

  def create?
    new?
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
