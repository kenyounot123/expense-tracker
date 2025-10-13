class Category < ApplicationRecord
  has_many :category_expenses, dependent: :destroy
  has_many :expenses, through: :category_expenses
  validates :name, presence: true, uniqueness: true

  def to_expense
    [ name, expenses.spendings.sum(:amount).to_f.round(2) ]
  end
end
