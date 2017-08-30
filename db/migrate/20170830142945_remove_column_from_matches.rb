class RemoveColumnFromMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :soccer_power_index
  end
end
