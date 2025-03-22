module CategoriesHelper
  def selected_categories(expense)
    return [] if expense.categories.empty?

    expense.categories.map { |category| { value: category.name, text: category.name } }
  end

  def selected_categories_for_search(categories)
    return [] if categories.nil?

    categories.map { |category| { value: category, text: category } }
  end

  def parse_data_for_multiselect(data)
    data.to_json.to_s.gsub("=>", ":")
  end
end
