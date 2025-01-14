require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in_as(@user)
    @current_expense = expenses(:fried_rice)
    @new_expense = expenses(:shopping_expense)
  end

  test "should get index" do
    get expenses_url
    assert_response :success
    assert_equal @user.expenses.count, Expense.where(user_id: @user.id).count
  end

  test "should get new" do
    get new_expense_url
    assert_response :success
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          amount: 75.0,
          description: "Utilities",
          date: "2023-10-03",
          expense_type: "Utilities",
          income: false,
          category_ids: [ categories(:food).id ]
        }
      }
    end

    assert_redirected_to expenses_url
  end

  test "should show expense" do
    get expense_url(@current_expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_url(@current_expense)
    assert_response :success
  end

  test "should update expense" do
    patch expense_url(@current_expense), params: {
      expense: {
        description: "Updated Rent",
        category_ids: [ categories(:housing).id ]
      }
    }
    assert_redirected_to expense_url(@current_expense)
  end

  test "should destroy expense" do
    assert_difference("Expense.count", -1) do
      delete expense_url(@current_expense)
    end

    assert_redirected_to expenses_url
  end
end
