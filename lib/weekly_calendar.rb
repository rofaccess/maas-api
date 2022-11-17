class WeeklyCalendar
  def initialize(beginning_of_week = nil)
    @beginning_of_week = beginning_of_week || Time.zone.now.beginning_of_week
    @current_week_number = week_number(@beginning_of_week)
  end

  def build_weekly_calendars(past_calendars_quantity = 0, future_calendars_quantity = 0)
    past_calendars = build_past_calendars(past_calendars_quantity, @beginning_of_week)
    current_calendar = build_calendar(@beginning_of_week)
    future_calendars = build_future_calendars(future_calendars_quantity, @beginning_of_week)
    past_calendars + [current_calendar] + future_calendars
  end

  private

  # From beginning_of_week = Mon, 14 Nov 2022 00:00:00 -0300
  # Return hash like this
  # {
  #   name: "Week 46 of 2022",
  #   start_date: "14/11/2022",
  #   end_date: "20/11/2022",
  #   current_week: true,
  #   days: [
  #     { name: "monday", date: "14/11/2022" }
  #     { name: "tuesday", date: "15/11/2022" }
  #     { name: "wednesday", date: "16/11/2022" }
  #     { name: "thursday", date: "17/11/2022 "}
  #     { name: "friday", date: "18/11/2022" }
  #     { name: "saturday", date: "19/11/2022" }
  #     { name: "sunday", date: "20/11/2022" }
  #  ]
  # }
  def build_calendar(beginning_of_week)
    current_week = @current_week_number == week_number(beginning_of_week)
    days = build_calendar_days(beginning_of_week)
    {
      name: name(beginning_of_week),
      start_date:  days.first[:date],
      end_date: days.last[:date],
      current_week: current_week,
      days: days
    }
  end

  def name(beginning_of_week)
    week_number = week_number(beginning_of_week)
    year = beginning_of_week.year
    "Week #{week_number} of #{year}"
  end

  def week_number(beginning_of_week)
    beginning_of_week.to_date.cweek
  end

  def build_calendar_days(beginning_of_week)
    days = []
    7.times do
      days << {
        name: beginning_of_week.strftime("%A").downcase,
        date: beginning_of_week.strftime("%d/%m/%Y")
      }
      beginning_of_week += 1.day
    end
    days
  end

  def build_past_calendars(past_calendars_quantity, beginning_of_week)
    (-past_calendars_quantity..-1).map do |counter|
      build_calendar(beginning_of_week + counter.week)
    end
  end

  def build_future_calendars(future_calendars_quantity, beginning_of_week)
    (1..future_calendars_quantity).map do |counter|
      build_calendar(beginning_of_week + counter.week)
    end
  end
end
