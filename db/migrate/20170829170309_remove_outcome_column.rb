class RemoveOutcomeColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :outcome
  end
end
