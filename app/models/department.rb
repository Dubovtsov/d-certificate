# t.string "name"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

class Department < ApplicationRecord
  require 'csv'

  include PgSearch::Model
  include GenerateCsv
  pg_search_scope :search_department, against: [:name]

  has_many :positions, dependent: :destroy
  before_save { name.downcase! }
  validates :name, presence: true
  validates :name, uniqueness: true
  default_scope { order(name: :asc) }

  def self.import_csv(file)
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
