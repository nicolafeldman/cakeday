class AddHappinessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :happiness, :float, :default => 1.0
  end
end
