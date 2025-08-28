class TeamPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:team_members).where(team_members: { user: })
    end
  end

  class AcceptedScope < TeamPolicy::Scope
    def resolve
      super.where(team_members: { status: :accepted })
    end
  end

  def index?
    user
  end

  def show?
    member_of_team?(:accepted)
  end

  def new?
    !exists?
  end

  def create?
    new?
  end

  def edit?
    user == record.recipient.creator
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def invitations?
    member_of_team?(:pending)
  end

  def accept?
    invitations?
  end

  def decline?
    invitations?
  end

  private

  def member_of_team?(status)
    scope.exists?(team_members: { team: record, status: })
  end
end
