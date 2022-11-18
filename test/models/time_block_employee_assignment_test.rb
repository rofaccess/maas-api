require "test_helper"

class TimeBlockEmployeeAssignmentTest < ActiveSupport::TestCase
  test "Should get day" do
    assert_equal("tuesday", time_block_employee_assignments(:one).day_name)
  end
end
