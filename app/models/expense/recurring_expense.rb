module Expense::RecurringExpense
  extend ActiveSupport::Concern

  included do
    scope :monthly, -> { where(expense_type: "monthly") }
    scope :yearly, -> { where(expense_type: "yearly") }
    scope :recurring, -> { where(expense_type: [ "monthly", "yearly" ]) }
  end

  def recurring?
    expense_type == "monthly" || expense_type == "yearly"
  end
end
