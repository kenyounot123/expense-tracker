class SearchesController < ApplicationController
  layout "search"

  def index
    query = search_params[:query].to_s

    @expenses = if query.present?
      Current.user.expenses.where("description LIKE ? COLLATE NOCASE", "%#{query}%")
    else
      Current.user.expenses
    end

    if params[:sort].present?
      sort_column = params[:sort]
      sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      @expenses = @expenses.order("#{sort_column} #{sort_direction}")
    end

    if search_params[:filters].present?
      @expenses = @expenses.apply_filters(search_params[:filters])
    end
  end

  private

  def search_params
    params.permit(:query, :sort, :direction, filters: [ :expense_type, :income, :start_date, :end_date ])
  end
end
