# t.boolean "legal_entity"
# t.string "request_number"
# t.string "request_link"
# t.date "end_date"
# t.string "status"
# t.string "e_service"
# t.bigint "employee_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["employee_id"], name: "index_certificates_on_employee_id"

class Certificate < ApplicationRecord
  require 'csv'
  extend Enumerize
  I18n.locale = :ru
  enumerize :status, in: [:draft, :verify, :current, :rejected, :archive, :recalled], default: :draft, i18n_scope: "status", scope: :shallow

  belongs_to :employee
  default_scope { order(updated_at: :desc) }

  scope :select_by_status, -> (status) { where(status: status) if status.present? }
  scope :select_legal_entity, -> { where(legal_entity: true)}
  # Ex:- scope :active, -> {where(:active => true)}

  ActiveAdmin.register Certificate do
    permit_params :legal_entity, :request_number, :end_date, :status, :e_service
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      parent_id = row['employee_id']
      @employee = Employee.find(parent_id)
      unless Certificate.exists?(request_number: row['request_number'])
        @certificate = @employee.certificates.build row.to_hash
      end
      @certificate.save!
    end
  end

  def start_time
    end_date
  end

  def self.two_months_left_counter
    @certificates_two_months_left = Certificate.all.select do |t|
      ((t.end_date - DateTime.now).to_i < 60) && ((t.end_date - DateTime.now).to_i > 30)
    end

    if @certificates_two_months_left.present?
      @certificates_two_months_left.count
    else
      '0'
    end
  end

  def self.one_months_left_counter
    @certificates_one_months_left = Certificate.all.select do |t|
      ((t.end_date - DateTime.now).to_i < 30 && (t.end_date > DateTime.now) && t.status != "archive")
    end

    if @certificates_one_months_left.present?
      @certificates_one_months_left.count
    else
      '0'
    end
  end

  def self.certificate_status_counter(status)
    @certificates_status = Certificate.where({ status: status })

    if @certificates_status.present?
      @certificates_status.count
    else
      '0'
    end
  end

  def two_months_left
    ((self.end_date - DateTime.now).to_i < 60) && ((self.end_date - DateTime.now).to_i > 30)
  end

  def one_months_left
    (self.end_date - DateTime.now).to_i < 30 && (status == :current)
    # (end_date - DateTime.now).to_i < 30 && (status == :current)
  end

  def status_class
    case status
    when "draft"
      'bg-gray-300'
    when "verify"
      'bg-yellow-300'
    when "current"
      'bg-green-300'
    when "rejected"
      'bg-red-300'
    when "recalled"
      'bg-red-300'
    when "archive"
      'bg-gray-300'
    else
      ''
    end
  end
end
