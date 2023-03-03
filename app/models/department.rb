class Department < ApplicationRecord
  require 'csv'
  include GenerateCsv

  has_many :positions, dependent: :destroy
  before_save { name.downcase! }
  validates :name, presence: true
  validates :name, uniqueness: true
  default_scope { order(name: :asc) }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Department.create! row.to_hash unless Department.exists?(name: row['name'])
    end
  end

  ActiveAdmin.register Department do
    permit_params :name
  end

  def self.search(search)
    if search
      Department.where('name LIKE ?', "%#{search.downcase}%")
    else
      Department.all
    end
  end
end
