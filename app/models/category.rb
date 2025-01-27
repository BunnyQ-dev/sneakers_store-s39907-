class Category < ApplicationRecord
  has_many :sneakers
  validates :name, presence: true, uniqueness: true
end