class AddUniqueConstraintToWeeklyMonitoringCalendars < ActiveRecord::Migration[7.0]
  def change
    add_index :weekly_monitoring_calendars,
              %i[monitored_service_id start_at end_at], unique: true,
                                                        name: "index_mo_ser_id_st_at_en_at"
  end
end
