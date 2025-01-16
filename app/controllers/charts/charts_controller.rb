class Charts::ChartsController < ApplicationController
  before_action :set_user

  def income
    render json: @user.expenses.income.group_by_month(:date).sum(:amount)
  end

  def spendings
    render json: @user.expenses.spendings.group_by_month(:date).sum(:amount)
  end

  def profits
    render json: @user.expenses.group_by_month(:date).sum(:amount)
  end

  private
    def set_user
      @user = User.find(chart_params[:user_id])
    end

    def chart_params
      params.permit(:user_id)
    end
end
