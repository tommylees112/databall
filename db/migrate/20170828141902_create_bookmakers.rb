class CreateBookmakers < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmakers do |t|
      t.string :logo
      t.string :url

      t.timestamps
    end
  end
end
