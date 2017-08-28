class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.references :user, foreign_key: true
      t.references :odd, foreign_key: true
      t.float :stake
      t.boolean :won

      t.timestamps
    end
  end
end
