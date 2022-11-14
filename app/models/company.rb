class Company < ApplicationRecord
  def as_json(*)
    super(only: %i[id name])
  end
end
