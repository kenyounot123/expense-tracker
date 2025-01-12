require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_expense = expenses(:cursor_expense)
    @new_expense = expenses(:shopping_expense)

    @new_expense.categories << categories(:food)
    @current_expense.categories << categories(:housing)
  end

  test "should get index" do
    get expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_url
    assert_response :success
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: { expense: @new_expense.attributes }
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
    patch expense_url(@current_expense), params: { expense: @new_expense.attributes }
    assert_redirected_to expense_url(@current_expense)
  end

  test "should destroy expense" do
    assert_difference("Expense.count", -1) do
      delete expense_url(@current_expense)
    end

    assert_redirected_to expenses_url
  end
end
