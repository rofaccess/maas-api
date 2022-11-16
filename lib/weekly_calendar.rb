class WeeklyCalendar
  def initialize(pivot = nil)
    @pivot = pivot || DateTime.now.beginning_of_week
  end

  def build(past_calendars_quantity = 0, future_calendars_quantity = 0)
    past_calendars = build_past_calendars(past_calendars_quantity, @pivot)
    current_calendar = [build_calendar(@pivot)]
    future_calendars = build_future_calendars(future_calendars_quantity, @pivot)
    past_calendars + current_calendar + future_calendars
  end

  private

  # From beginning_of_week = Mon, 14 Nov 2022 00:00:00 -0300
  # Return hash like this
  # {
  #   :name=>"Week 46 of 2022",
  #   :details=>[
  #     {:day=>"monday", :date=>"14/11/2022"},
  #     {:day=>"tuesday", :date=>"15/11/2022"},
  #     {:day=>"wednesday", :date=>"16/11/2022"},
  #     {:day=>"thursday", :date=>"17/11/2022"},
  #     {:day=>"friday", :date=>"18/11/2022"},
  #     {:day=>"saturday", :date=>"19/11/2022"},
  #     {:day=>"sunday", :date=>"20/11/2022"}]
  # }
  def build_calendar(beginning_of_week)
    {
      name: name(beginning_of_week),
      details: build_calendar_details(beginning_of_week)
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

  def build_calendar_details(beginning_of_week)
    details = []
    7.times do
      details << {
        day: beginning_of_week.strftime("%A").downcase,
        date: beginning_of_week.strftime("%d/%m/%Y")
      }
      beginning_of_week += 1.day
    end
    details
  end

  def build_past_calendars(past_calendars_quantity, current_beginning_of_week)
    (-past_calendars_quantity..-1).map do |counter|
      build_calendar(current_beginning_of_week + counter.week)
    end
  end

  def build_future_calendars(future_calendars_quantity, current_beginning_of_week)
    (1..future_calendars_quantity).map do |counter|
      build_calendar(current_beginning_of_week + counter.week)
    end
  end
end
