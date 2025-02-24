require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in_as(@user)
  end

  test "should get index" do
    get searches_url
    assert_response :success
  end
end
