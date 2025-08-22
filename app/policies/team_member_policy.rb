class TeamMemberPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(team: team_scope)
    end

    private

    def team_scope
      TeamPolicy::Scope.new(user, Team).resolve
    end
  end

  def new?
    record.user != record.recipient.creator
  end

  def create?
    new?
  end

  def destroy?
    new?
  end
end
