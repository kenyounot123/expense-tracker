class ChartsController < ApplicationController
  before_action :set_user

  def income
    render json: @user.expenses.income.group_by_month(:date).sum(:amount)
  end

  def spendings
    render json: @user.expenses.spendings.group_by_month(:date).sum(:amount)
  end

  def profits
    income_by_month = @user.expenses.income.group_by_month(:date).sum(:amount)
    spending_by_month = @user.expenses.spendings.group_by_month(:date).sum(:amount)

    # Need to negate income to mark it as a positive value (by default expenses are negative)
    profits_by_month = income_by_month.merge(spending_by_month) { |_, income, spending| -income + spending }

    render json: profits_by_month
  end

  private
    def set_user
      @user = Current.user
    end
end
