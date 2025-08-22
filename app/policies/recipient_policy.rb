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
    true
  end

  def new?
    user
  end

  def create?
    new?
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
    edit? && record.ideas_count < Idea::MAX_IDEA_COUNT
  end
end
