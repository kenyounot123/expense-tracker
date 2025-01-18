module ExpensesHelper
  SORT_DIRECTIONS = %w[asc desc].freeze

  def income?
    expense.income
  end

  def sort_by_direction
    return "Recent" unless SORT_DIRECTIONS.include?(params[:sort])

    case params[:sort]
    when SORT_DIRECTIONS.first
      "Oldest"
    else
      "Recent"
    end
  end
end
