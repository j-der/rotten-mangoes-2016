class RenameImageColumn < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.rename :poster_img, :poster_image
    end
  end
end
