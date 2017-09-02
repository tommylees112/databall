class AddFixtureUrlToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :url, :string
  end
end
