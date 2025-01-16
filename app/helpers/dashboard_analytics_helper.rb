module DashboardAnalyticsHelper
  VALID_CHART_TYPES = %w[income spendings profits].freeze

  def format_analytics_type(type)
    case type.to_sym
    when :spendings
      "Spent"
    else
      type.to_s.titleize
    end
  end

  def chart_path_for(type)
    type = (type || "spendings").to_s
    type = "spendings" unless VALID_CHART_TYPES.include?(type)

    case type
    when "income"
      charts_income_path
    when "spendings"
      charts_spendings_path
    when "profits"
      charts_profits_path
    end
  end
end
