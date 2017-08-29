class CreateMatchModelOutputs < ActiveRecord::Migration[5.0]
  def change
    create_table :match_model_outputs do |t|
      t.float :home_win_probability
      t.float :away_win_probability
      t.float :draw_probability
      t.datetime :date_updated
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
