class FavoriteProductPolicy < ApplicationPolicy
  class Scope < RecipientPolicy::Scope
    def resolve
      scope.where(recipient: recipient_scope)
    end

    private

    def recipient_scope
      RecipientPolicy::Scope.new(user, Recipient).resolve
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    exists?
  end
end
