class ChangeNumericFieldInTourRequests < ActiveRecord::Migration[6.1]
  def change
    change_column :tour_requests, :total_price, :decimal, precision: 5, scale: 1
  end
end
