class WeeklyMonitoringCalendar < ApplicationRecord
  belongs_to :monitored_service
  delegate :year, to: :start_at

  def as_json(*)
    super(only: %i[id monitored_service_id start_at end_at], methods: %i[name])
  end

  def name
    "Week #{week_number} of #{year}"
  end

  def week_number
    start_at.to_date.cweek
  end
end
