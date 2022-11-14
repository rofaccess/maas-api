require "test_helper"

class WeeklyMonitoringCalendarTest < ActiveSupport::TestCase
  test "Should get name" do
    weekly_monitoring_calendar = weekly_monitoring_calendars(:one)
    assert_equal("Week 45 of 2022", weekly_monitoring_calendar.name)
  end
end
