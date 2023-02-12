class PersonalDatum < ApplicationRecord
  require 'csv'
  belongs_to :employee

  validates :inn, length: { is: 12 }, presence: true
  validates :passport_s, length: { is: 4 }
  validates :passport_n, length: { is: 6 }

  def issued_by_all
    "#{issued_by}, #{date_of_issue.present? ? date_of_issue.strftime('%d.%m.%Y') : '-'}, #{code}"
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      parent_id = row['employee_id']
      @employee = Employee.find(parent_id)
      @personal_datum = @employee.build_personal_datum row.to_hash unless PersonalDatum.exists?(inn: row['inn'],
                                                                                                snils: row['snils'])
      @personal_datum.save!
    end
  end
end
