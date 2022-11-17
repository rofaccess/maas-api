class TimeBlockEmployeeAssignment < ApplicationRecord
  belongs_to :time_block
  belongs_to :employee

  def as_json(*)
    super(only: %i[id employee_id start_at end_at], methods: %i[])
  end

  class << self
    def build(employee_id)
      time_block_employee_assignments = TimeBlockEmployeeAssignment.where(employee_id: employee_id)
      time_block_employee_assignments.each do |time_block_employee_assignment|
        a = 2
      end
    end
  end
end
