module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    before_action :set_source
    before_action :set_breadcrumb_path
  end

  private
    def set_breadcrumb_path
      case @source
      when "search"
        add_breadcrumb "Dashboard", expenses_path
        add_breadcrumb "Search Expenses", searches_path(request.query_parameters.except(:source))
      else
        add_breadcrumb "Dashboard", expenses_path
      end
    end

    def set_source
      @source = params.dig(:source)
      unless @source.nil?
        determine_source
      end
    end

    def determine_source
      @source = if request.referer&.include?("/searches")
        "search"
      else
        "expenses"
      end
    end
end
