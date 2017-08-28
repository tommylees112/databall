class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :home_team, foreign_key: {to_table: :teams}
      t.references :away_team, foreign_key: {to_table: :teams}
      t.integer :goals_home_team
      t.integer :goals_away_team
      t.datetime :match_date
      t.integer :gameweek
      t.references :league, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
