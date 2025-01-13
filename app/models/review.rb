class Review < ApplicationRecord
  belongs_to :sneaker

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  validates :user_name, presence: true
end