class CategoriesController < ApplicationController
  def index
    @categories = Category.where("LOWER(name) LIKE LOWER(?)", "%#{params[:q]}%") if params[:q].present?

    @categories = Category.all if params[:q].blank?
    respond_to do |format|
      format.json { render json: @categories.map { |category| { value: category.name, text: category.name } } }
    end
  end
end
