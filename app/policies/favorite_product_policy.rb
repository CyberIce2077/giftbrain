class FavoriteProductPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end
end
