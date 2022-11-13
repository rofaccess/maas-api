class AddUniqueConstraintToMonitoredServicesName < ActiveRecord::Migration[7.0]
  def change
    add_index :monitored_services, :name, unique: true
  end
end
