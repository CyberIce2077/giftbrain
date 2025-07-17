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
    show? && allowed_status?
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

  private

  def allowed_status?
    record.draft_status? || record.failed_status? || record.success_status?
  end
end
