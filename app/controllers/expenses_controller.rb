class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_total_spendings, only: %i[ index show ]
  before_action :set_breadcrumb_path, only: %i[ show edit ]
  before_action :set_source, except: %i[ index ]

  def index
    @pagy, @expenses = pagy(current_user_expenses.includes(:categories).order(created_at: sort_direction), items: 10)
    @total_income = current_user_expenses.total_income
  end

  def show
    add_breadcrumb @expense.description.truncate(20), nil
  end

  def new
    @expense = current_user_expenses.build
  end

  def edit
    add_breadcrumb @expense.description.truncate(20), expense_path(@expense, source: @source)
    add_breadcrumb "Edit", nil
  end

  def create
    @expense = current_user_expenses.build(expense_params.except(:category_names))

    if @expense.save
      @expense.attach_category_names(expense_params[:category_names])
      redirect_to expenses_path(source: @source), notice: "Expense created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params.except(:category_names))
      @expense.attach_category_names(expense_params[:category_names])
      redirect_to expense_path(source: @source), notice: "Expense updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy!
    if @source.present?
      redirect_to searches_path, notice: "Expense deleted successfully"
    else
      redirect_to expenses_path, notice: "Expense deleted successfully"
    end
  end

  private
    def set_expense
      @expense = current_user_expenses.find(params[:id])
    end

    def set_total_spendings
      @total_spendings = current_user_expenses.total_spendings
    end

    def set_source
      @source = params.dig(:source)
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
        :excluded,
        category_names: []
      )
    end

    def set_breadcrumb_path
      case params.dig(:source)
      when "search"
        add_breadcrumb "Dashboard", expenses_path
        add_breadcrumb "Search Expenses", searches_path(request.query_parameters.except(:source))
      else
        add_breadcrumb "Dashboard", expenses_path
      end
    end

    def set_breadcrumb_path
      @breadcrumb_path = if request.referer&.include?("/searches")
        "search"
      else
        "expenses"
      end
    end
end
