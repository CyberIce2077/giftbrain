class HomePolicy < ApplicationPolicy
  def about?
    true
  end

  def calendar?
    user
  end
end
