class Category < ApplicationRecord
  has_and_belongs_to_many :expenses
  validates :name, presence: true, uniqueness: true
end
