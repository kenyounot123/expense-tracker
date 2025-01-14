class Expense < ApplicationRecord
  include Calculatable

  has_and_belongs_to_many :categories
  belongs_to :user

  validates :amount, presence: true
  validates :date, presence: true
  validates :expense_type, presence: true
end
