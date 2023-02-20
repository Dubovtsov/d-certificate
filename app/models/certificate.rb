class Certificate < ApplicationRecord
  require 'csv'
  
  belongs_to :employee
  default_scope { order(updated_at: :desc) }

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
      ((t.end_date - DateTime.now).to_i < 30 && (t.end_date < DateTime.now) && t.status != 'архив')
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
    'two_months_left' if ((end_date - DateTime.now).to_i < 60) && ((end_date - DateTime.now).to_i > 30)
  end

  def one_months_left
    'one_months_left' if (end_date - DateTime.now).to_i < 30 && (status == 'действующий')
  end

  def status_class
    case status
    when 'черновик'
      'bg-gray-300'
    when 'на проверке'
      'bg-yellow-300'
    when 'действующий'
      'bg-green-300'
    when 'отклонен'
      'bg-red-300'
    else
      ''
    end
  end
end
