class TimeBlockEmployeeAssignment < ApplicationRecord
  belongs_to :time_block
  belongs_to :employee

  def as_json(*)
    super(only: %i[id time_block_id employee_id start_at end_at], methods: %i[employee_name color])
  end

  def day_name
    start_at.strftime("%A").downcase
  end
end
