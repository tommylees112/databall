class AddModelReferencesToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :team_model_output, foreign_key: true
  end
end
