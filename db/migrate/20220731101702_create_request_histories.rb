class CreateRequestHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :request_histories do |t|
      t.integer :quantity
      t.decimal :total_price
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
