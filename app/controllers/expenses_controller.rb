class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_total_spendings, only: %i[ index show ]

  def index
    @pagy, @expenses = pagy(current_user_expenses.includes(:categories).order(created_at: sort_direction))
    @total_income = current_user_expenses.total_income
  end

  def show
  end

  def new
    @expense = current_user_expenses.build
  end

  def edit
  end

  def create
    @expense = current_user_expenses.build(expense_params.except(:category_names))

    if @expense.save
      attach_categories
      redirect_to expenses_path, notice: "Expense created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params.except(:category_names))
      attach_categories
      redirect_to expense_path(@expense), notice: "Expense updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy!
    redirect_to expenses_path, notice: "Expense deleted successfully"
  end

  private
    def set_expense
      @expense = current_user_expenses.find(params[:id])
    end

    def set_total_spendings
      @total_spendings = current_user_expenses.total_spendings
    end

    def current_user_expenses
      Current.user.expenses
    end

    def sort_direction
      %w[asc desc].include?(params[:sort]) ? params[:sort] : "desc"
    end

    def expense_params
      params.require(:expense).permit(
        :amount,
        :description,
        :date,
        :expense_type,
        :income,
        category_names: []
      )
    end

    def attach_categories
      return if expense_params[:category_names].blank?

      categories = expense_params[:category_names].map do |name|
        Category.find_or_create_by!(name: name.strip)
      end
      
      @expense.categories = categories
    end
end
