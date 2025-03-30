class Expense < ApplicationRecord
  include Scoped, RecurringExpense, Filterable

  EXPENSE_TYPES = %w[one_time monthly yearly].freeze

  has_and_belongs_to_many :categories
  belongs_to :user

  validates :amount, presence: true
  validates :date, presence: true
  validates :expense_type, presence: true

  def attach_category_names(names)
    return if names.blank?

    self.categories = names.map do |name|
      Category.find_or_create_by!(name: name.strip)
    end
  end
end
