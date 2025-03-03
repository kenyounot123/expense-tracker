module DashboardAnalyticsHelper
  VALID_FILTER_TYPES = %w[income spendings profits].freeze
  VALID_CHART_TYPES = %w[monthly daily].freeze

  def format_analytics_type(type)
    case type.to_sym
    when :spendings
      "Spent"
    else
      type.to_s.titleize
    end
  end

  def chart_path_for(filter_type, chart_type)
    filter_type = (filter_type || "spendings").to_s
    chart_type = (chart_type || "monthly").to_s

    filter_type = "spendings" unless VALID_FILTER_TYPES.include?(filter_type)
    chart_type = "monthly" unless VALID_CHART_TYPES.include?(chart_type)

    case filter_type
    when "income"
      charts_income_path(chart_type: chart_type)
    when "spendings"
      charts_spendings_path(chart_type: chart_type)
    when "profits"
      charts_profits_path
    end
  end
end
