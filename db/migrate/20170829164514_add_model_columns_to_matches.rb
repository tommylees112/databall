class AddModelColumnsToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :home_adj_goals, :float
    add_column :matches, :away_adj_goals, :float
    add_column :matches, :home_shot_xg, :float
    add_column :matches, :away_shot_xg, :float
    add_column :matches, :home_non_shot_xg, :float
    add_column :matches, :away_non_shot_xg, :float
  end
end
