class CreateOdds < ActiveRecord::Migration[5.0]
  def change
    create_table :odds do |t|
      t.references :match, foreign_key: true
      t.references :bookmaker, foreign_key: true
      t.float :odd
      t.string :outcome

      t.timestamps
    end
  end
end
