class EditRatingColumnNameAgain < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.rename :ratings_out_of_ten, :rating_out_of_ten
    end
  end
end
