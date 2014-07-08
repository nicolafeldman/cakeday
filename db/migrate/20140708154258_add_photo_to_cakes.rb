class AddPhotoToCakes < ActiveRecord::Migration
  def change
    add_column :cakes, :photo, :string, :default => 'http://cakepic4u.com/wp-content/uploads/2014/05/birthday-cakes-pictures-clip-art-4.jpg'
  end
end
