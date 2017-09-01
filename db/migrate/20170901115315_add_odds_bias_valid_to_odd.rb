class AddOddsBiasValidToOdd < ActiveRecord::Migration[5.0]
  def change
    add_column :odds, :odds_bias_filter, :boolean, default: false, null: false
  end
end
