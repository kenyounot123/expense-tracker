class CategoryExpense < ApplicationRecord
  belongs_to :category, counter_cache: :expenses_count
  belongs_to :expense
end
