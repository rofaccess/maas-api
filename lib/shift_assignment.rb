module ShiftAssignment
  class << self
    def time_block_assignments(monitored_service_id, start_at, end_at)
      shift_assignments_sql = shift_assignments_sql(monitored_service_id, start_at, end_at)
      shift_assignments = TimeBlockServiceAssignment.from("(#{shift_assignments_sql}) AS time_block_service_assignments")

      build_shift_assignments(shift_assignments)
    end

    private

    def build_shift_assignments(shift_assignments)
      items = {}
      employees = Employee.all.index_by(&:id)
      shift_assignments.each do |assignment|
        employee_ids = assignment.employee_ids
        color, employee_name = employee_data(employee_ids, employees)

        day_name = assignment.day_name
        time_block_name = assignment[:time_block_name]
        items[day_name] = {} unless items[day_name]
        items[day_name][time_block_name] = build_assignment(assignment, employee_name, color)
      end
      items
    end

    def employee_data(employee_ids, employees)
      case employee_ids.size
      when 0
        color = "red lighten-3" # Nothing employee is assigned in same time block
        employee_name = "No assigned"
      when 1
        employee = employees[employee_ids.to_i]
        color = employee.assigned_color # One employee is assigned in same time block
        employee_name = employee.name
      else
        color = "black" # when more than one employee is assigned in same time block
        employee_name = "Conflict"
      end

      [color, employee_name]
    end

    def build_assignment(assignment, employee_name, color)
      assignment = assignment.as_json
      assignment[:employee_name] = employee_name
      assignment[:color] = color
      assignment
    end

    def shift_assignments_sql(monitored_service_id, start_at, end_at)
      sql_query = <<-SQL
        with employees_assigned_to_services as (
          select service_assignments.*, string_agg(employees.id::text, ',') as employee_ids, time_blocks.name as time_block_name
          from time_block_service_assignments service_assignments
          inner join time_block_employee_assignments employee_assignments on employee_assignments.start_at = service_assignments.start_at
          inner join time_blocks on time_blocks.id = service_assignments.time_block_id
          inner join employees on employees.id = employee_assignments.employee_id
          group by service_assignments.id, time_blocks.name
        ),
        services_no_assigned_to_employees as (
          select service_assignments.*, ''::text as employee_ids, time_blocks.name as time_block_name
          from time_block_service_assignments service_assignments
          left join employees_assigned_to_services on employees_assigned_to_services.id = service_assignments.id
          inner join time_blocks on time_blocks.id = service_assignments.time_block_id
          where employees_assigned_to_services.id is null
        ),
        services_assigned_and_not as (
          select * from employees_assigned_to_services
          union
          select * from services_no_assigned_to_employees
        )
        select *
        from services_assigned_and_not
        where start_at >= :start_at and end_at <= :end_at
        order by start_at
      SQL

      ActiveRecord::Base.send :sanitize_sql_array, [
        sql_query,
        {
          monitored_service_id: monitored_service_id,
          start_at: start_at.to_time.beginning_of_week,
          end_at: end_at.to_time.end_of_week
        }
      ]
    end
  end
end
