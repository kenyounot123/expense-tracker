class RecurringExpenseJob < ApplicationJob
  queue_as :default

  # Finds all recurring expenses and performs the job if the next payment date is today
  # TODO: Refactor this, the job should just schedule the job not perform business logic, move business logic to model
  def perform
    Expense.recurring.find_each do |expense|
      create_next_expense(expense) if today_is_next_payment_date?(expense)
    end
  end

  private

  def create_next_expense(expense)
    return unless expense.recurring?

    attributes = expense.attributes.except("id", "created_at", "updated_at", "date")
    attributes["date"] = next_payment_date(expense)

    categories = expense.categories

    new_expense = Expense.create(attributes)
    new_expense.categories << categories if new_expense.persisted?
  end

  def today_is_next_payment_date?(expense)
    Date.today == next_payment_date(expense)
  end

  def next_payment_date(expense)
    case expense.expense_type
    when "monthly"
      expense.date.next_month
    when "yearly"
      expense.date.next_year
    end
  end
end
