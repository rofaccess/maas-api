class TimeBlockEmployeeAssignment < ApplicationRecord
  belongs_to :time_block
  belongs_to :employee

  def as_json(*)
    super(only: %i[id time_block_id employee_id start_at end_at], methods: %i[employee_name employee_color])
  end

  def day_name
    start_at.strftime("%A").downcase
  end

  class << self
    def save_all(params)
      records_to_destroy = records_to_destroy(params)
      records_to_destroy.destroy_all

      records_to_save = records_to_save(params)
      TimeBlockEmployeeAssignment.import(records_to_save, on_duplicate_key_ignore: true)
    end

    private

    def records_to_destroy(params)
      records_to_destroy_ids = []
      params[:items].each { |item| records_to_destroy_ids.push(item[:id]) if item[:_destroy] }
      TimeBlockEmployeeAssignment.where(id: records_to_destroy_ids)
    end

    def records_to_save(params)
      time_blocks = TimeBlock.pluck(:id, :name).to_h
      records_to_save = []
      params[:items].each do |item|
        next if item[:id]

        build_record_to_save(item, records_to_save, time_blocks)
      end
      records_to_save
    end

    def build_record_to_save(item, records_to_save, time_blocks)
      day, month, year = item[:date].split("/").map(&:to_i)
      time_block = time_blocks[item[:time_block_id]].split(" - ")
      hour, minute = time_block[0].split(":").map(&:to_i)
      start_at = Time.zone.local(year, month, day, hour, minute)
      records_to_save.push({
                             time_block_id: item[:time_block_id],
                             employee_id: item[:employee_id],
                             start_at: start_at,
                             end_at: start_at + 1.hour
                           })
    end
  end
end
