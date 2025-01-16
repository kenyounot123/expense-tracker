class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_total_spendings, only: %i[ index show ]

  def index
    @expenses = expenses.includes(:categories).all
    @total_income = expenses.total_income
    @spendings_by_month = expenses.spendings.group_by_month(:date).sum(:amount)
  end

  def show
  end

  def new
    @expense = expenses.build
  end

  def edit
  end

  def create
    @expense = expenses.build(expense_params)
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
      @expense = expenses.find(params[:id])
    end

    def set_total_spendings
      @total_spendings = expenses.total_spendings
    end

    def expenses
      Current.user.expenses
    end

    def expense_params
      params.require(:expense).permit(:amount, :description, :date, :expense_type, :income, :category_ids)
    end
end
