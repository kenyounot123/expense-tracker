class ChartsController < ApplicationController
  before_action :set_user
  before_action :set_chart_type

  def income
    case @chart_type
    when "monthly"
      render json: @user.expenses.income.group_by_month(:date, format: "%B %Y").sum(:amount)
    when "daily"
      render json: @user.expenses.income.group_by_day(:date, format: "%b %d").sum(:amount)
    else
      render json: @user.expenses.income.group_by_month(:date, format: "%B %Y").sum(:amount)
    end
  end

  def spendings
    case @chart_type
    when "monthly"
      render json: @user.expenses.spendings.group_by_month(:date, format: "%B %Y").sum(:amount)
    when "daily"
      render json: @user.expenses.spendings.group_by_day(:date, format: "%b %d").sum(:amount)
    else
      render json: @user.expenses.spendings.group_by_month(:date, format: "%B %Y").sum(:amount)
    end
  end

  def profits
    render json: profits_by_month
  end

  private
    def set_user
      @user = Current.user
    end

    def set_chart_type
      @chart_type = permitted_params[:chart_type]
    end

    def profits_by_month
      income_by_month = @user.expenses.income.group_by_month(:date).sum(:amount)
      spending_by_month = @user.expenses.spendings.group_by_month(:date).sum(:amount)

      # Determine which hash has more months because we need to iterate over the larger one
      larger_month_amount_hash = income_by_month.size > spending_by_month.size ? income_by_month : spending_by_month

      # If one month has income but not spending(or vice versa), we need to skip it, because profit can only be calculated if both income and spending are present
      profits_by_month = {}
      larger_month_amount_hash.each do |month, amount|
        next unless income_by_month.has_key?(month) && spending_by_month.has_key?(month)
        profits_by_month[month] = income_by_month[month] - spending_by_month[month]
      end
      profits_by_month
    end

    def permitted_params
      params.permit(:chart_type, chart: {})
    end
end
