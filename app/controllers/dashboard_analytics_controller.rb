class DashboardAnalyticsController < ApplicationController
  def show
    @type = permitted_params[:filter_type]&.to_sym || :spendings

    @total = case @type
    when :income
      Current.user.expenses.total_income
    when :spendings
      Current.user.expenses.total_spendings
    when :profits
      Current.user.expenses.total_income - Current.user.expenses.total_spendings
    end

    render layout: false if turbo_frame_request?
  end

  private

  def permitted_params
    params.permit(:filter_type, :chart_type)
  end
end
