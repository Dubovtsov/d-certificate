class CreateCertificates < ActiveRecord::Migration[7.0]
  def change
    create_table :certificates do |t|
      t.boolean :legal_entity
      t.string :request_number
      t.string :request_link
      t.date :end_date
      t.string :status
      t.string :e_service
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
