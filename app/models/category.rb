class Category < ApplicationRecord
  has_many :tours, dependent: :destroy

  validates :category_name, presence: true
end
