class AddNameToBookmakers < ActiveRecord::Migration[5.0]
  def change
    add_column :bookmakers, :name, :string
  end
end
