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
# Create sample categories
# Create sample expenses
expenses = [
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 1200.00,
    description: "Monthly Rent",
    date: Date.today,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 85.50,
    description: "Grocery Shopping",
    date: Date.today - 2.days,
    expense_type: "One-Time"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 45.00,
    description: "Netflix Subscription",
    date: Date.today - 5.days,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 120.00,
    description: "Electricity Bill",
    date: Date.today - 1.week,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 60.00,
    description: "Internet Service",
    date: Date.today - 3.days,
    expense_type: "Monthly"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 25.99,
    description: "Book Purchase",
    date: Date.today - 1.day,
    expense_type: "One-Time"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 499.99,
    description: "New Phone",
    date: Date.today - 2.weeks,
    expense_type: "One-Time"
  },
  {
    user_id: User.find_by(email_address: "bob@gmail.com").id,
    amount: 150.00,
    description: "Car Insurance",
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
