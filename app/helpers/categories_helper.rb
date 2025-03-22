module CategoriesHelper
  def selected_categories(expense)
    return [] if expense.categories.empty?

    expense.categories.map { |category| { value: category.name, text: category.name } }
  end

  def parse_data_for_multiselect(data)
    data.to_json.to_s.gsub("=>", ":")
  end
end
