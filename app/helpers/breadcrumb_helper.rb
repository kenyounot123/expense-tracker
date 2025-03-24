module BreadcrumbHelper
  def expense_breadcrumb_items(expense, path_type)
    case path_type
    when "search"
      [
        { title: "Dashboard", path: expenses_path },
        { title: "Search Expenses", path: searches_path },
        { title: expense.description.truncate(20), path: nil }
      ]
    else
      [
        { title: "Dashboard", path: expenses_path },
        { title: expense.description.truncate(20), path: nil }
      ]
    end
  end
end
