class ChangeTeamModelReferencesDirection < ActiveRecord::Migration[5.0]
  def change
    remove_reference :teams, :team_model_output
  end
end
