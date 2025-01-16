module DashboardAnalyticsHelper
  def format_analytics_type(type)
    case type.to_sym
    when :spendings
      "Spent"
    else
      type.to_s.titleize
    end
  end
end
