class Expense < ApplicationRecord
  include Scoped, RecurringExpense

  EXPENSE_TYPES = %w[one_time monthly yearly].freeze

  has_and_belongs_to_many :categories
  belongs_to :user

  validates :amount, presence: true
  validates :date, presence: true
  validates :expense_type, presence: true

  scope :filter_by_expense_type, ->(expense_type) { where(expense_type: expense_type) if expense_type.present? }
  scope :filter_by_income, ->(income) { where(income: income) unless income.nil? }
  scope :filter_by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) if start_date.present? && end_date.present? }

  def self.apply_filters(filters = {})
    return all unless filters.present?

    result = all
    result = result.filter_by_expense_type(filters[:expense_type]) if filters[:expense_type].present?
    result = result.filter_by_income(filters[:income]) if filters[:income].present?
    result = result.filter_by_date_range(filters[:start_date], filters[:end_date]) if filters[:start_date].present? && filters[:end_date].present?
    result
  end
end
