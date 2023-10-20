class EmployeePosition < ApplicationRecord
  belongs_to :employee
  belongs_to :position

  before_validation :set_default_rate

  private

  def set_default_rate
    self.rate ||= 1
  end
  
end
