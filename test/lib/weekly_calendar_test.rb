require "test_helper"

class WeeklyCalendarTest < ActiveSupport::TestCase
  test "Should build weekly calendar" do
    datetime = Time.zone.local(2022, 11, 14)
    weekly_calendar = WeeklyCalendar.new(datetime)
    weekly_calendars = weekly_calendar.build_weekly_calendars
    assert_equal(1, weekly_calendars.size)
    first_weekly_calendar = weekly_calendars.first
    assert_equal("Week 46 of 2022", first_weekly_calendar[:name])
    assert_equal("14/11/2022", first_weekly_calendar[:start_date])
    assert_equal("20/11/2022", first_weekly_calendar[:end_date])

    days = first_weekly_calendar[:days]

    assert_equal("monday", days[0][:name])
    assert_equal("14/11/2022", days[0][:date])

    assert_equal("tuesday", days[1][:name])
    assert_equal("15/11/2022", days[1][:date])

    assert_equal("wednesday", days[2][:name])
    assert_equal("16/11/2022", days[2][:date])

    assert_equal("thursday", days[3][:name])
    assert_equal("17/11/2022", days[3][:date])

    assert_equal("friday", days[4][:name])
    assert_equal("18/11/2022", days[4][:date])

    assert_equal("saturday", days[5][:name])
    assert_equal("19/11/2022", days[5][:date])

    assert_equal("sunday", days[6][:name])
    assert_equal("20/11/2022", days[6][:date])
  end

  test "Should build five weekly calendar" do
    datetime = Time.zone.local(2022, 11, 14)
    weekly_calendar = WeeklyCalendar.new(datetime)
    weekly_calendars = weekly_calendar.build_weekly_calendars(3, 1)
    assert_equal(5, weekly_calendars.size)
    first_weekly_calendar = weekly_calendars.first
    assert_equal("Week 43 of 2022", first_weekly_calendar[:name])
  end
end
