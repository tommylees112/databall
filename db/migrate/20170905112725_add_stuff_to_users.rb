class AddStuffToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_customer, :jsonb
    add_column :users, :access, :boolean
    add_column :users, :stripe_subscription, :jsonb
    add_column :users, :trial_end, :datetime
  end
end
