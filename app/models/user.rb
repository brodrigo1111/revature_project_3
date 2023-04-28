class User < ApplicationRecord
  has_secure_password
  has_many :decks, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: {minimum: 1, maximum: 20}
  validates :password, presence: true, length: {minimum: 1, maximum: 20}
end
