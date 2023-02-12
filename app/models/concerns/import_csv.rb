module ImportCsv
  extend ActiveSupport::Concern
  require 'csv'

  class_methods do
    def import_csv(file)
      CSV.foreach(file.path, headers: true) do |row|
        self.create!(Hash[row])
      end
    end
  end
end