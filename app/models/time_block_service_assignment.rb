class TimeBlockServiceAssignment < ApplicationRecord
  belongs_to :time_block
  belongs_to :monitored_service
end
