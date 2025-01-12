class ExpensesController < ApplicationController
  allow_unauthenticated_access
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_total_expenses, only: %i[ index show ]

  def index
    @expenses = Expense.includes(:categories).all
    @total_income = Expense.total_income
    @spendings_by_month = Expense.expenses.group_by_month(:date).sum(:amount)
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)
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
      @expense = Expense.find(params[:id])
    end

    def set_total_expenses
      @total_expenses = Expense.total_expenses
    end

    def expense_params
      params.require(:expense).permit(:amount, :description, :date, :expense_type, :income, :category_ids)
    end
end
