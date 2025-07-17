class HomeController < ApplicationController
  def index
    authorize :home
    skip_policy_scope
  end

  def about
    authorize :home
  end
end
