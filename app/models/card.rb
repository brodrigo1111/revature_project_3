class Card < ApplicationRecord
  belongs_to :deck, optional: true
  validates :front, presence: true, length: {maximum: 100, minimum: 1}
  validates :back, presence: true, length: {maximum: 100, minimum: 1}
end
