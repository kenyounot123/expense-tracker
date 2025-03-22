class SearchesController < ApplicationController
  layout "search"

  def index
    @expenses = Current.user.expenses.filter_by(params)

    if params[:sort].present?
      sort_column = params[:sort]
      sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      @expenses = @expenses.order("#{sort_column} #{sort_direction}")
    end
  end

  private

  def search_params
    params.permit(:query, :sort, :direction, :expense_type, :income, :start_date, :end_date, :categories)
  end
end
