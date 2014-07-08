class AddBakedByToCakes < ActiveRecord::Migration
  def change
    add_column :cakes, :baked_by, :string
  end
end
