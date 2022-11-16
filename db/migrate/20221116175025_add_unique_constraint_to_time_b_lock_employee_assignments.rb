class AddUniqueConstraintToTimeBLockEmployeeAssignments < ActiveRecord::Migration[7.0]
  def change
    add_index :time_block_employee_assignments,
              %i[time_block_id employee_id start_at end_at], unique: true,
                                                             name: "index_ti_bl_id_em_id_st_at_en_at"
  end
end
