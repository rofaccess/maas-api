class TimeBlockEmployeeAssignment < ApplicationRecord
  belongs_to :time_block
  belongs_to :employee
end
