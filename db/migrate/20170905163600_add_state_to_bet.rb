class AddStateToBet < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :status, :integer, default: 0
    remove_column :bets, :won
    remove_column :matches, :outcome
  end
end
