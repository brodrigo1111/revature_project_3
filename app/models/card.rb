class Card < ApplicationRecord
  belongs_to :deck, optional: true
  validates :front, presence: true
  validates :back, presence: true
end
