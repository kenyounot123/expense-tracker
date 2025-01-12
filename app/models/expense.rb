class Expense < ApplicationRecord
  validates :amount, presence: true
  validates :date, presence: true
  validates :expense_type, presence: true
end
