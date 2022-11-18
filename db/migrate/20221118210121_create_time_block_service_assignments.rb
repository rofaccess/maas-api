class CreateTimeBlockServiceAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :time_block_service_assignments do |t|
      t.references :time_block, null: false, foreign_key: true
      t.references :monitored_service, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
