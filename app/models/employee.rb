class Employee < ApplicationRecord
  def as_json(*)
    super(only: %i[id name assigned_color])
  end

  class << self
    def time_block_assignments(employee_id, start_date, end_date)
      employee_assignments = employee_assignments(employee_id, start_date, end_date)
      items = {}
      employee_assignments.each do |employee_assignment|
        day_name = employee_assignment.day_name
        time_block_name = employee_assignment[:time_block_name]
        items[day_name] = {} unless items[day_name]
        items[day_name][time_block_name] = employee_assignment.as_json
      end
      items
    end

    private

    def employee_assignments(employee_id, start_date, end_date)
      start_at = start_date.to_time.beginning_of_week
      end_at = end_date.to_time.end_of_week

      TimeBlockEmployeeAssignment
        .joins(:time_block, :employee)
        .where(employee_id: employee_id)
        .where("start_at >= ?", start_at)
        .where("end_at <= ?", end_at)
        .select("time_block_employee_assignments.*, time_blocks.name as time_block_name,
                employees.assigned_color as employee_color,
                employees.name as employee_name")
    end
  end
end
