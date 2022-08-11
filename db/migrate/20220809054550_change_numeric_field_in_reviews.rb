class ChangeNumericFieldInReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :rating, :decimal, precision: 5, scale: 1
  end
end
