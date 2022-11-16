class TimeBlock < ApplicationRecord
  class << self
    def build_all
      start_at = DateTime.current.beginning_of_day
      time_blocks = []
      24.times do
        start_time = start_at.strftime("%H:%M")
        start_at += 1.hour
        end_time = start_at.strftime("%H:%M")
        time_blocks << TimeBlock.new(name: "#{start_time} - #{end_time}")
      end
      time_blocks
    end
  end
end
