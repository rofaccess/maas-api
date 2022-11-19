class TimeBlockServiceAssignment < ApplicationRecord
  belongs_to :time_block
  belongs_to :monitored_service

  def day_name
    start_at.strftime("%A").downcase
  end
end
