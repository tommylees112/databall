class AddColumnToTeamModelOutputs < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :soccer_power_index, :float
  end
end
