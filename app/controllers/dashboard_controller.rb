class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @certificates = Certificate.all
  end
end
