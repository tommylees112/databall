class CreateTeamModelOutputs < ActiveRecord::Migration[5.0]
  def change
    create_table :team_model_outputs do |t|
      t.float :defensive_score
      t.float :offensive_score
      t.float :simulated_wins
      t.float :simulated_losses
      t.float :simulated_draws
      t.float :simulated_goal_difference
      t.float :simulated_season_total
      t.float :relegation_probability
      t.float :ucl_probability
      t.string :league_win_probability
      t.datetime :last_updated
      t.float :promotion_probability
      t.float :playoff_probability

      t.timestamps
    end
  end
end
