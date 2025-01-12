class Expense < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user

  validates :amount, presence: true
  validates :date, presence: true
  validates :expense_type, presence: true

  scope :income, -> { where(income: true) }
  scope :expenses, -> { where(income: false) }

  def self.total_income
    income.sum(:amount)
  end

  def self.total_expenses
    expenses.sum(:amount)
  end
end
