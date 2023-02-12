class CreateEmployeePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_positions do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.float :rate

      t.timestamps
    end
  end
end
