class AddUniqueConstraintToTimeBlocksName < ActiveRecord::Migration[7.0]
  def change
    add_index :time_blocks, :name, unique: true
  end
end
