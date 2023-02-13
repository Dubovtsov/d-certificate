class Certificate < ApplicationRecord
  require 'csv'
  belongs_to :employee

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
end
