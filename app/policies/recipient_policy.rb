class RecipientPolicy < ApplicationPolicy
  class Scope < RecipientPolicy::Scope
    def resolve
      scope.where(creator: user).or(scope.where(id: team_accepted_scope.pluck(:recipient_id)))
    end

    private

    def team_accepted_scope
      TeamPolicy::AcceptedScope.new(user, Team).resolve
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user
  end

  def create?
    new?
  end

  def edit?
    return unless user == record.creator

    exists? && record.editable?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def generate_ideas?
    exists? && record.editable? && record.recipient_ideas_count < Idea::MAX_IDEA_COUNT
  end
end
