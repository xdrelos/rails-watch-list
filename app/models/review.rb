class Review < ApplicationRecord
  belongs_to :list
  validates :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 0..5,
    message: "%{value} is not between 0 and 5" }
end
