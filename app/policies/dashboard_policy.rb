class DashboardPolicy < ApplicationPolicy
  def index?
    user.admin_role?
  end
end
