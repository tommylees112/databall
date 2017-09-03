class AddFractionalOddsToOdds < ActiveRecord::Migration[5.0]
  def change
    add_column :odds, :frac_odd, :string
  end
end
