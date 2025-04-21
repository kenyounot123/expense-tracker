class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]

  def index
    if params[:q].present?
      @categories = Category.where("LOWER(name) LIKE LOWER(?)", "%#{params[:q]}%")
    else
      @categories = Category.all
    end

    @expenses = Current.user.expenses.includes(:categories).order(date: :desc)

    respond_to do |format|
      format.json { render json: @categories.map { |category| { value: category.name, text: category.name } } }
      format.html { render :index }
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        flash[:notice] = "Category created successfully"
        format.turbo_stream
        format.html { redirect_to categories_path, data: { turbo_frame: "_top" } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("modal", partial: "categories/form", locals: { category: @category, show_delete: false }) }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    @category.update!(category_params)
    flash[:notice] = "Category updated successfully"
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to categories_path, data: { turbo_frame: "_top" } }
    end
  end

  def destroy
    @category.destroy
    @expenses = Current.user.expenses.includes(:categories).order(date: :desc)
    flash[:notice] = "Category deleted successfully"
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to categories_path, data: { turbo_frame: "_top" } }
    end
  end

  def create_from_select
    category_name = JSON.parse(request.body.read)["addable"]
    category = Category.create!(name: category_name)

    render json: { text: category.name, value: category.name }
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def apply_category
    return unless params[:name].present?

    @category = Category.find_by(name: params[:name])
    @expenses = Expense.where(id: params[:expense_ids])
    ActiveRecord::Base.transaction do
      @expenses.each do |expense|
        expense.categories << @category unless expense.categories.include?(@category)
      end
    end
    redirect_to categories_path, notice: "Category successfully applied to selected expenses"
  end

  private

    def category_params
      params.require(:category).permit(:name, expense_ids: [])
    end

    def set_category
      @category = Category.find(params[:id])
    end
end
