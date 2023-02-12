class Position < ApplicationRecord
  belongs_to :department
  has_many :employee_positions
  has_many :employees, through: :employee_positions

  before_save { name.downcase! }

  validates :name, presence: true

  def name_with_department
    self.department.name + " : " + self.name
  end
end
