module Expense::Calculatable
  extend ActiveSupport::Concern

  included do
    scope :income, -> { where(income: true) }
    scope :expenses, -> { where(income: false) }
    scope :total_income, -> { income.sum(:amount) }
    scope :total_expenses, -> { expenses.sum(:amount) }
  end
end
