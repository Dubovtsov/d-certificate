class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @certificates = Certificate.select_without_status(:archive)
  end
end
