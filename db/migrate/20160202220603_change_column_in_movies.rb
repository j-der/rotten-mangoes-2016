class ChangeColumnInMovies < ActiveRecord::Migration
  def change
    remove_column :users, :avatar
    add_column :movies, :poster_img, :string
  end
end
