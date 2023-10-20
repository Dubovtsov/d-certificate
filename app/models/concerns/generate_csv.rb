module GenerateCsv
  extend ActiveSupport::Concern

  require 'csv'

  class_methods do
    def generate_csv
      CSV.generate(headers: true) do |csv|
        csv << %w[last_name first_name middle_name]

        all.each do |record|
          csv << [record.last_name, record.first_name, record.middle_name]
        end
      end
    end
  end

  # class_methods do
  #   def generate_csv
  #     CSV.generate(headers: true) do |csv|
  #       csv << self.attribute_names

  #       all.each do |record|
  #         csv << record.attributes.values
  #       end
  #     end
  #   end
  # end
end
