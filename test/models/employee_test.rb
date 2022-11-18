require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  test "Should build time_block_assignments" do
    time_block_employee_assignments = Employee.time_block_assignments(employees(:one).id)
    assert_equal(["tuesday"], time_block_employee_assignments.keys)
    tuesday_assignments = time_block_employee_assignments["tuesday"]
    assert_equal(["19:00 - 20:00", "20:00 - 21:00"], tuesday_assignments.keys)
  end
end
