class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :categories, -> { distinct }, through: :expenses

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
