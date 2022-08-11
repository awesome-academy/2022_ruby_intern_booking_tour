class ChangeNumericFieldInTours < ActiveRecord::Migration[6.1]
  def change
    change_column :tours, :price, :decimal, precision: 5, scale: 1
    change_column :tours, :avg_rating, :decimal, precision: 5, scale: 1
  end
end
