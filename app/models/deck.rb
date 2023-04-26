class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user, optional: true
  validates :name, presence: true, uniqueness: true
end
