class ChangeOddsColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :odds, :odd, :odds
  end
end
