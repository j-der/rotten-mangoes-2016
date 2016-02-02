class EditRatingColumnName < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.rename :rating_out_of_ten, :ratings_out_of_ten
    end
  end
end
