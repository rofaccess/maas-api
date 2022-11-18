require "test_helper"

class TimeBlockTest < ActiveSupport::TestCase
  test "Should build time blocks" do
    assert_equal(24, TimeBlock.build_time_blocks.size)
  end
end
