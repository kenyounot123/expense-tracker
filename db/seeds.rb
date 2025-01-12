# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Expense.destroy_all

# Create sample expenses
expenses = [
  {
    amount: 1200.00,
    description: "Monthly Rent",
    category: "Housing",
    date: Date.today,
    expense_type: "Monthly"
  },
  {
    amount: 85.50,
    description: "Grocery Shopping",
    category: "Food",
    date: Date.today - 2.days,
    expense_type: "One-Time"
  },
  {
    amount: 45.00,
    description: "Netflix Subscription",
    category: "Entertainment",
    date: Date.today - 5.days,
    expense_type: "Monthly"
  },
  {
    amount: 120.00,
    description: "Electricity Bill",
    category: "Utilities",
    date: Date.today - 1.week,
    expense_type: "Monthly"
  },
  {
    amount: 60.00,
    description: "Internet Service",
    category: "Utilities",
    date: Date.today - 3.days,
    expense_type: "Monthly"
  },
  {
    amount: 25.99,
    description: "Book Purchase",
    category: "Education",
    date: Date.today - 1.day,
    expense_type: "One-Time"
  },
  {
    amount: 499.99,
    description: "New Phone",
    category: "Electronics",
    date: Date.today - 2.weeks,
    expense_type: "One-Time"
  },
  {
    amount: 150.00,
    description: "Car Insurance",
    category: "Insurance",
    date: Date.today,
    expense_type: "Monthly"
  }
]

# Create each expense
expenses.each do |expense_data|
  expense = Expense.create!(expense_data)
  puts "Created expense: #{expense.description}"
end

puts "Created #{Expense.count} expenses"
