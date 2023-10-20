class Employee < ApplicationRecord
  require 'csv'
  include GenerateCsv

  has_many :employee_positions, dependent: :destroy
  has_many :positions, through: :employee_positions, dependent: :destroy
  accepts_nested_attributes_for :employee_positions
  has_one :personal_datum, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many_attached :files
  accepts_nested_attributes_for :personal_datum
  accepts_nested_attributes_for :employee_positions
  accepts_nested_attributes_for :certificates

  validates :last_name, presence: true
  validates :first_name, presence: true
  before_save :normalize_name

  default_scope { order(last_name: :asc) }

  def name_with_initial
    "#{last_name.capitalize} #{first_name.capitalize} #{middle_name.capitalize}"
  end

  def initials
    if last_name? && first_name?
      "#{last_name[0]}#{first_name[0]}"
    end
  end
  

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Employee.create! row.to_hash unless Employee.exists?(last_name: row['last_name'], first_name: row['first_name'])
    end
  end

  private

  def normalize_name
    self.first_name = first_name.upcase
    self.last_name = last_name.upcase
    self.middle_name = middle_name.upcase
  end
end
