class TeamMemberPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(team: team_base_scope)
    end

    private

    def team_base_scope
      TeamPolicy::Scope.new(user, Team).resolve
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    record.user != record.recipient.creator
  end
end
