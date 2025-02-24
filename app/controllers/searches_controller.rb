class SearchesController < ApplicationController
  layout "search"

  def index
    query = search_params[:query].to_s

    @expenses = if query.present?
      Current.user.expenses.where("description LIKE ? COLLATE NOCASE", "%#{query}%")
    else
      Current.user.expenses
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end
