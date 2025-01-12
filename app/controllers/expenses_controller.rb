class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]

  def index
    @expenses = Expense.all
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
  end

  def destroy
    @expense.destroy!
  end

  private
    def set_expense
      @expense = Expense.find(params.expect(:id))
    end

    def expense_params
      params.expect(expense: [ :amount, :description, :category, :date, :expense_type, :description ])
    end
end
