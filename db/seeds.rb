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
Category.destroy_all
# Create sample categories
categories = [
  { name: "Housing" },
  { name: "Food" },
  { name: "Entertainment" },
  { name: "Utilities" },
  { name: "Education" },
  { name: "Electronics" },
  { name: "Insurance" }
]
# Create sample expenses
expenses = [
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 1200.00,
    description: "Monthly Rent",
    categories: [ "Housing" ],
    date: Date.today,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 85.50,
    description: "Grocery Shopping",
    categories: [ "Food" ],
    date: Date.today - 2.days,
    expense_type: "One-Time"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 45.00,
    description: "Netflix Subscription",
    categories: [ "Entertainment" ],
    date: Date.today - 5.days,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 120.00,
    description: "Electricity Bill",
    categories: [ "Utilities" ],
    date: Date.today - 1.week,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 60.00,
    description: "Internet Service",
    categories: [ "Utilities" ],
    date: Date.today - 3.days,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 25.99,
    description: "Book Purchase",
    categories: [ "Education" ],
    date: Date.today - 1.day,
    expense_type: "One-Time"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 499.99,
    description: "New Phone",
    categories: [ "Electronics" ],
    date: Date.today - 2.weeks,
    expense_type: "One-Time"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 150.00,
    description: "Car Insurance",
    categories: [ "Insurance" ],
    date: Date.today,
    expense_type: "Monthly"
  }
]

# Create each category
categories.each do |category_data|
  category = Category.create!(category_data)
  puts "Created category: #{category.name}"
end
# Create each expense
expenses.each do |expense_data|
  # Extract categories before creating expense
  categories_names = expense_data.delete(:categories)
  expense = Expense.create!(expense_data)

  # Find and associate categories
  categories_names.each do |category_name|
    category = Category.find_by!(name: category_name)
    expense.categories << category
  end

  puts "Created expense: #{expense.description}"
end


puts "Created #{Expense.count} expenses"
puts "Created #{Category.count} categories"
