class WeeklyCalendarsController < ApplicationController
  def index
    weekly_calendar = WeeklyCalendar.new
    weekly_calendars = weekly_calendar.build(0, 5)
    render json: weekly_calendars
  end
end
