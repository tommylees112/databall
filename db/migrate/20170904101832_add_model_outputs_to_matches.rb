class AddModelOutputsToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :final_home_win_probability, :float
    add_column :matches, :final_away_win_probability, :float
    add_column :matches, :final_draw_probability, :float
    add_column :matches, :outcome, :string
  end
end
