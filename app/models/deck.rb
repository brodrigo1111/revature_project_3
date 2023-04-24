class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  validates :name, uniqueness: true, presence: true
end
