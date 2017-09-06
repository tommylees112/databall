class ChangeDefaultInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :access, true
  end
end
