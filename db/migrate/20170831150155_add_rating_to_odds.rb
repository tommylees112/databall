class AddRatingToOdds < ActiveRecord::Migration[5.0]
  def change
    add_column :odds, :rating, :float
  end
end
