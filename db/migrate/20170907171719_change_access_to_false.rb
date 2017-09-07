class ChangeAccessToFalse < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :access, false
  end
end
