class Category::BreakdownsController < ApplicationController
  include Breadcrumbs

  before_action :set_category, only: [ :show ]

  def index
    add_breadcrumb("Category Breakdown", nil)
    @categories = Current.user.categories
  end

  def show
    add_breadcrumb("Category Breakdown", category_breakdowns_path)
    add_breadcrumb(@category.name.truncate(20), nil)

    @pagy, @expenses = pagy(@category.expenses.order(date: :desc))
    @total_spent = @category.expenses.sum(:amount)
    @average_per_expense = @expenses.any? ? @total_spent / @expenses.count : 0

    # Get spending trend for the last 6 months
    @monthly_spending = @category.expenses
      .where("date >= ?", 6.months.ago)
      .group_by_month(:date, format: "%b %Y")
      .sum(:amount)
  end

  private
    def set_category
      @category = Current.user.categories.find(params[:id])
    end
end
