class AddSpiColumnToTeamModelOutputs < ActiveRecord::Migration[5.0]
  def change
    add_column :team_model_outputs, :soccer_power_index, :float
  end
end
