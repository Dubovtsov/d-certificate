class DashboardController < ApplicationController
  def index
    @certificates = Certificate.all
  end
end
