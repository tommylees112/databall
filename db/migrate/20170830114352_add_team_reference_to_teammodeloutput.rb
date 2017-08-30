class AddTeamReferenceToTeammodeloutput < ActiveRecord::Migration[5.0]
  def change
    add_reference :team_model_outputs, :team, foreign_key: true, index: true
  end
end
