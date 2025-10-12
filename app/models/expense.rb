class Expense < ApplicationRecord
  include Scoped, RecurringExpense, Filterable

  EXPENSE_TYPES = %w[one_time monthly yearly].freeze

  has_many :category_expenses, dependent: :destroy
  has_many :categories, through: :category_expenses

  belongs_to :user

  validates :amount, presence: true
  validates :date, presence: true
  validates :expense_type, presence: true

  scope :from_last_month, -> {
    where(date: 1.month.ago.beginning_of_month..1.month.ago.end_of_month)
  }

  def attach_category_names(names)
    return if names.blank?

    self.categories = names.map do |name|
      Category.find_or_create_by!(name: name.strip)
    end
  end
end
