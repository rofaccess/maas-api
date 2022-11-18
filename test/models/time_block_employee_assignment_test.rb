require "test_helper"

class TimeBlockEmployeeAssignmentTest < ActiveSupport::TestCase
  test "Should build time_block_employee_assignments" do
    time_block_employee_assignments = TimeBlockEmployeeAssignment.buildTimeBlockEmployeeAssignments(employees(:one).id)
    assert(time_block_employee_assignments)
  end
end
