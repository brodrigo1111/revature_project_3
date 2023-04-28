class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user, optional: true
  validates :name, presence: true, length: {minimum: 1, maximum: 30}
end
