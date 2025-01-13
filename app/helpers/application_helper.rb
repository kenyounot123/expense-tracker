module ApplicationHelper
  def prefers_color_scheme?(scheme)
    # Get the color-scheme from meta tag (defaults to "dark")
    current_scheme = content_for(:color_scheme) || "dark"
    current_scheme.to_s == scheme.to_s
  end

  def chart_color_for_scheme
    prefers_color_scheme?(:light) ? "#000000" : "#FFFFFF"
  end
end
