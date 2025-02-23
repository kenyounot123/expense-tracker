module Expense::Scoped
  extend ActiveSupport::Concern

  included do
    scope :income, -> { where(income: true) }
    scope :spendings, -> { where(income: false) }
    scope :total_income, -> { income.sum(:amount) }
    scope :total_spendings, -> { spendings.sum(:amount) }
  end
end
