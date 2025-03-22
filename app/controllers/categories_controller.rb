class CategoriesController < ApplicationController
  def index
    @categories = Category.where("LOWER(name) LIKE LOWER(?)", "%#{params[:q]}%") if params[:q].present?

    @categories = Category.all if params[:q].blank?
    respond_to do |format|
      format.json { render json: @categories.map { |category| { value: category.name, text: category.name } } }
    end
  end

  def create_from_select
    category_name = JSON.parse(request.body.read)["addable"]
    category = Category.create!(name: category_name)

    render json: { text: category.name, value: category.name }
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
