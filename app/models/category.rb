class Category < ApplicationRecord
  has_many :tours, dependent: :destroy

  validates :name, presence: true
end
