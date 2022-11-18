require "test_helper"

class TableTest < ActiveSupport::TestCase
  test "Should print table" do
    Table.print(TimeBlock.all)
  end
end
