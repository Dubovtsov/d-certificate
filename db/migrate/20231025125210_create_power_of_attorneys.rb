class CreatePowerOfAttorneys < ActiveRecord::Migration[7.0]
  def change
    create_table :power_of_attorneys do |t|
      t.string :title
      t.date :end_date
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
