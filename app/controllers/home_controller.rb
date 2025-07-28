class HomeController < ApplicationController
  def about
    authorize :home
  end
end
