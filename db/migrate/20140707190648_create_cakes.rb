class CreateCakes < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :flavor
      t.string :message
      t.integer :user_id
      t.boolean :has_been_given

      t.timestamps
    end
  end
end
