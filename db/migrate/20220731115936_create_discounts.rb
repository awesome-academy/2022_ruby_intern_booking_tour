class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.decimal :discount_rate
      t.boolean :activated, default: true
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
