module ExpensesHelper
  SORT_DIRECTIONS = %w[asc desc].freeze

  def income?
    expense.income
  end

  def sort_by_direction
    return "Recent" unless SORT_DIRECTIONS.include?(params[:sort])

    case params[:sort]
    when "asc" then "Oldest"
    when "desc" then "Recent"
    end
  end

  def user_total_spendings
    Current.user.expenses.total_spendings
  end
end
