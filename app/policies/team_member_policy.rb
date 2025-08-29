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
    user == record.creator
  end

  def create?
    new?
  end

  def destroy?
    record.permitted_to_destroy?(user)
  end
end
