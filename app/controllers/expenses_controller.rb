class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_total_spendings, only: %i[ index show ]

  def index
    @expenses = current_user_expenses.includes(:categories).order(created_at: sort_direction).all
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
    @expense = current_user_expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "Expense created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
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
      %w[asc desc].include?(params[:sort]) ? params[:sort] : "asc"
    end

    def expense_params
      params.require(:expense).permit(:amount, :description, :date, :expense_type, :income, :category_ids)
    end
end
