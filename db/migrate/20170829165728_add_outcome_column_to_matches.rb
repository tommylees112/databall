class AddOutcomeColumnToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :outcome, :string
  end
end
