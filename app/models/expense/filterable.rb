module Expense::Filterable
  extend ActiveSupport::Concern

  included do
    scope :by_expense_type, ->(expense_type) { where(expense_type: expense_type) }
    scope :by_income, ->(income) { where(income: income) unless income.nil? }
    scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }
    scope :by_query, ->(query) { where("description LIKE ? COLLATE NOCASE", "%#{query}%") }
    scope :by_categories, ->(category_names) { 
      joins(:categories)
        .where(categories: { name: category_names })
        .distinct
    }
  end

  class_methods do  
    def filter_by(params = {})
      relation = self
      relation = relation.by_expense_type(params[:expense_type]) if params[:expense_type].present?
      relation = relation.by_income(params[:income]) if params[:income].present?
      relation = relation.by_date_range(params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
      relation = relation.by_query(params[:query]) if params[:query].present?
      relation = relation.by_categories(params[:categories]) if params[:categories].present?
      relation.all
    end
  end
end
