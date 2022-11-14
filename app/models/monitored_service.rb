class MonitoredService < ApplicationRecord
  belongs_to :company

  def as_json(*)
    super(only: %i[id name])
  end
end
