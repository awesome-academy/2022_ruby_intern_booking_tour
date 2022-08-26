class CreateNotification < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: true, foreign_key: true
      t.text :content
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
