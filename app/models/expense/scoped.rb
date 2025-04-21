module Expense::Scoped
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(excluded: false) }
    scope :excluded, -> { where(excluded: true) }

    scope :income, -> { active.where(income: true) }
    scope :spendings, -> { active.where(income: false) }

    scope :total_income, -> { income.sum(:amount) }
    scope :total_spendings, -> { spendings.sum(:amount) }
  end
end
