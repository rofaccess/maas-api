require "test_helper"

class WeeklyCalendarTest < ActiveSupport::TestCase
  test "Should build weekly calendar" do
    datetime = DateTime.new(2022, 11, 14)
    weekly_calendar = WeeklyCalendar.new(datetime)
    weekly_calendars = weekly_calendar.build
    assert_equal(1, weekly_calendars.size)
    first_weekly_calendar = weekly_calendars.first
    assert_equal("Week 46 of 2022", first_weekly_calendar[:name])

    details = first_weekly_calendar[:details]

    assert_equal("monday", details[0][:day])
    assert_equal("14/11/2022", details[0][:date])

    assert_equal("tuesday", details[1][:day])
    assert_equal("15/11/2022", details[1][:date])

    assert_equal("wednesday", details[2][:day])
    assert_equal("16/11/2022", details[2][:date])

    assert_equal("thursday", details[3][:day])
    assert_equal("17/11/2022", details[3][:date])

    assert_equal("friday", details[4][:day])
    assert_equal("18/11/2022", details[4][:date])

    assert_equal("saturday", details[5][:day])
    assert_equal("19/11/2022", details[5][:date])

    assert_equal("sunday", details[6][:day])
    assert_equal("20/11/2022", details[6][:date])
  end

  test "Should build five weekly calendar" do
    datetime = DateTime.new(2022, 11, 14)
    weekly_calendar = WeeklyCalendar.new(datetime)
    weekly_calendars = weekly_calendar.build(3, 1)
    assert_equal(5, weekly_calendars.size)
    first_weekly_calendar = weekly_calendars.first
    assert_equal("Week 43 of 2022", first_weekly_calendar[:name])
  end
end
