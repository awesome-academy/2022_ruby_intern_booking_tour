class CreateTours < ActiveRecord::Migration[6.1]
  def change
    create_table :tours do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :avg_rating
      t.datetime :start_date
      t.datetime :end_date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
