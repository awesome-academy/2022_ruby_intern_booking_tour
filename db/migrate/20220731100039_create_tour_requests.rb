class CreateTourRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_requests do |t|
      t.integer :quantity
      t.decimal :total_price
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
