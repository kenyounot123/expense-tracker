class DashboardAnalyticsController < ApplicationController
  def show
    @type = params[:type]&.to_sym || :spendings

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
end
