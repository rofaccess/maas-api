require "test_helper"

class TimeBlockEmployeeAssignmentTest < ActiveSupport::TestCase
  test "Should build time_block_employee_assignments" do
    time_block_employee_assignments = TimeBlockEmployeeAssignment.build(employees(:one).id)
  end
end
