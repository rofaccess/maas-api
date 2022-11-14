class CreateWeeklyMonitoringCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :weekly_monitoring_calendars do |t|
      t.references :monitored_service, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
