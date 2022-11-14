class Employee < ApplicationRecord
  def as_json(*)
    super(only: %i[id name assigned_color])
  end
end
