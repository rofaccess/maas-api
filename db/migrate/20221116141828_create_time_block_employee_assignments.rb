class CreateTimeBlockEmployeeAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :time_block_employee_assignments do |t|
      t.references :time_block, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
