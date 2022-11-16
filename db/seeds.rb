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

# Create weekly_monitoring_calendars
beginning_of_week = DateTime.now.beginning_of_week
end_of_week = DateTime.now.end_of_week

gmail_monitored_service = MonitoredService.find_by(name: "Gmail")
weekly_monitoring_calendars = []

# Create 6 old weekly calendars for Gmail service
(-6..-1).each do |counter|
  weekly_monitoring_calendars.push({
                                     monitored_service_id: gmail_monitored_service.id,
                                     start_at: beginning_of_week + counter.week,
                                     end_at: end_of_week + counter.week
                                   })
end

# Create 1 weekly calendar for Gmail service for current week
weekly_monitoring_calendars.push({
                                   monitored_service_id: gmail_monitored_service.id,
                                   start_at: beginning_of_week,
                                   end_at: end_of_week
                                 })

aws_monitored_service = MonitoredService.find_by(name: "AWS")
# Create 6 future weekly calendars for AWS service
6.times do |counter|
  weekly_monitoring_calendars.push({
                                     monitored_service_id: aws_monitored_service.id,
                                     start_at: beginning_of_week + counter.week,
                                     end_at: end_of_week + counter.week
                                   })
end

WeeklyMonitoringCalendar.import(weekly_monitoring_calendars, on_duplicate_key_ignore: true)

# Create employees
employees = [
  { name: "Ernesto", assigned_color: "amber lighten-1" },
  { name: "Benjamin", assigned_color: "light-blue lighten-4" },
  { name: "Barbara", assigned_color: "#f8bbd0 pink lighten-4" }
]

Employee.import(employees, on_duplicate_key_update: { conflict_target: [:name], columns: [:assigned_color] })

# Create time_blocks
TimeBlock.import(TimeBlock.build_all, on_duplicate_key_ignore: true)
