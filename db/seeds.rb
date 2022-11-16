# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create companies
companies = [
  { name: "Google" },
  { name: "Yahoo" },
  { name: "Amazon" }
]

# on_duplicate_key_ignore: true is to avoid insert records with same name according unique constraint in name attribute
Company.import(companies, on_duplicate_key_ignore: true)

# Create monitored_services
google_company = Company.find_by(name: "Google")
amazon_company = Company.find_by(name: "Amazon")
monitored_services = [
  { name: "Gmail", company_id: google_company.id },
  { name: "Drive", company_id: google_company.id },
  { name: "AWS", company_id: amazon_company.id }
]

MonitoredService.import(monitored_services, on_duplicate_key_ignore: true)

# Create employees
employees = [
  { name: "Ernesto", assigned_color: "amber lighten-1" },
  { name: "Benjamin", assigned_color: "light-blue lighten-4" },
  { name: "Barbara", assigned_color: "#f8bbd0 pink lighten-4" }
]

Employee.import(employees, on_duplicate_key_update: { conflict_target: [:name], columns: [:assigned_color] })

# Create time_blocks
TimeBlock.import(TimeBlock.build_all, on_duplicate_key_ignore: true)

ActiveRecord::Base.transaction do
  # Build time_block_employee_assignments for 2 weekly calendar
  ernesto_employee = Employee.find_by(name: "Ernesto")
  barbara_employee = Employee.find_by(name: "Barbara")
  benjamin_employee = Employee.find_by(name: "Benjamin")

  time_block_assignments = [
    {
      employee_id: ernesto_employee.id,
      details: [
        { day: "tuesday", start_time: "19:00", end_time: "00:00" },
        { day: "thursday", start_time: "19:00", end_time: "00:00" },
        { day: "friday", start_time: "19:00", end_time: "00:00" },
        { day: "saturday", start_time: "10:00", end_time: "15:00" }
      ]
    },
    {
      employee_id: barbara_employee.id,
      details: [
        { day: "tuesday", start_time: "19:00", end_time: "00:00" },
        { day: "wednesday", start_time: "19:00", end_time: "00:00" },
        { day: "thursday", start_time: "19:00", end_time: "00:00" },
        { day: "friday", start_time: "19:00", end_time: "00:00" },
        { day: "saturday", start_time: "18:00", end_time: "21:00" },
        { day: "sunday", start_time: "10:00", end_time: "00:00" }
      ]
    },
    {
      employee_id: benjamin_employee.id,
      details: [
        { day: "monday", start_time: "19:00", end_time: "00:00" },
        { day: "tuesday", start_time: "19:00", end_time: "00:00" },
        { day: "wednesday", start_time: "19:00", end_time: "00:00" },
        { day: "thursday", start_time: "19:00", end_time: "00:00" }
      ]
    }
  ]

  time_blocks = TimeBlock.all.index_by(&:name)
  weekly_calendar_builder = WeeklyCalendar.new
  weekly_calendars = weekly_calendar_builder.build(0, 1)

  time_block_employee_assignments = []
  weekly_calendars.each_value do |weekly_calendar|
    time_block_assignments.each do |time_block_assignment|
      employee_id = time_block_assignment[:employee_id]
      time_block_assignment[:details].each do |time_block_assignment_detail|
        string_date = weekly_calendar[:details][time_block_assignment_detail[:day]][:date]
        day, month, year = string_date.split("/").map(&:to_i)
        hour, minute = time_block_assignment_detail[:start_time].split(":").map(&:to_i)
        start_at = Time.zone.local(year, month, day, hour, minute)
        loop do
          start_time = start_at.strftime("%H:%M")
          end_at = start_at + 1.hour
          end_time = end_at.strftime("%H:%M")
          time_block_name = "#{start_time} - #{end_time}"
          time_block = time_blocks[time_block_name]

          time_block_employee_assignments << {
            time_block_id: time_block.id,
            employee_id: employee_id,
            start_at: start_at,
            end_at: end_time == "00:00" ? end_at - 1.second : end_at
          }

          start_at = end_at
          break if end_time == time_block_assignment_detail[:end_time]
        end
      end
    end
  end

  TimeBlockEmployeeAssignment.import(time_block_employee_assignments, on_duplicate_key_ignore: true)
end
