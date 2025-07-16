class HomeController < ApplicationController
  def index
    authorize :home
  end

  def about
    authorize :home
  end
end
