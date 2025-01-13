class Sneaker < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end