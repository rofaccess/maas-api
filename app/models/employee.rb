class Employee < ApplicationRecord
  def as_json(*)
    super(only: %i[id name assigned_color])
  end

  class << self
    def time_block_assignments(employee_id, start_date, end_date)
      employee_assignments = employee_assignments(employee_id, start_date, end_date)
      _employee_assignments = {}
      employee_assignments.each do |employee_assignments|
        day_name = employee_assignments.day_name
        time_block_name = employee_assignments[:time_block_name]
        _employee_assignments[day_name] = {} unless _employee_assignments[day_name]
        _employee_assignments[day_name][time_block_name] = employee_assignments.as_json
      end
      _employee_assignments
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
        .select("*, time_blocks.name as time_block_name,
                employees.assigned_color as color,
                employees.name as employee_name")
    end
  end
end
