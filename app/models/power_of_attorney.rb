class PowerOfAttorney < ApplicationRecord
  belongs_to :employee
  validates :title, presence: true
end
