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
