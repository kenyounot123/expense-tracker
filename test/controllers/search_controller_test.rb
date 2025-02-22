require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in_as(@user)
  end

  test "should get all expenses that match query" do
    search_string = "rice"
  end
end
