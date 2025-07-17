class HomePolicy < ApplicationPolicy
  def index?
    true
  end

  def about?
    true
  end
end
