module Expense::Filterable
  extend ActiveSupport::Concern

  included do
    scope :by_expense_type, ->(expense_type) { where(expense_type: expense_type) if expense_type.present? }
    scope :by_income, ->(income) { where(income: income) unless income.nil? }
    scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) if start_date.present? && end_date.present? }
    scope :by_query, ->(query) { where("description LIKE ? COLLATE NOCASE", "%#{query}%") if query.present? }
  end

  class_methods do  
    def filter_by(params = {})
      relation = self
      relation = relation.by_expense_type(params[:expense_type]) if params[:expense_type].present?
      relation = relation.by_income(params[:income]) if params[:income].present?
      relation = relation.by_date_range(params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
      relation = relation.by_query(params[:query]) if params[:query].present?
      relation.all
    end
  end
end
