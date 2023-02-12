class CreatePersonalData < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_data do |t|
      t.string :snils
      t.string :inn
      t.string :passport_s
      t.string :passport_n
      t.string :issued_by
      t.date :date_of_issue
      t.string :code
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :phone_number
      t.string :email
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
