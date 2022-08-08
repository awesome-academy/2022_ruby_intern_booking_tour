class AddStockToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :stock, :integer
  end
end
