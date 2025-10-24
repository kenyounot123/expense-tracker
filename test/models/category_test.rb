require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should belong to user" do
    category = categories(:john_food)
    assert_equal users(:john), category.user
  end

  test "should require user" do
    category = Category.new(name: "Test Category")
    assert_not category.valid?
    assert_includes category.errors[:user], "must exist"
  end

  test "users should not see other users' categories" do
    john = users(:john)
    bob = users(:bob)

    john_categories = Category.where(user: john)
    bob_categories = Category.where(user: bob)

    # John should only see his own categories
    assert_equal 2, john_categories.count
    assert_includes john_categories, categories(:john_food)
    assert_includes john_categories, categories(:john_housing)
    assert_not_includes john_categories, categories(:bob_food)
    assert_not_includes john_categories, categories(:bob_transportation)

    # Bob should only see his own categories
    assert_equal 2, bob_categories.count
    assert_includes bob_categories, categories(:bob_food)
    assert_includes bob_categories, categories(:bob_transportation)
    assert_not_includes bob_categories, categories(:john_food)
    assert_not_includes bob_categories, categories(:john_housing)
  end

  test "category names can be duplicated across different users" do
    john = users(:john)
    bob = users(:bob)

    # Both users have a "Food" category
    john_food = Category.find_by(name: "Food", user: john)
    bob_food = Category.find_by(name: "Food", user: bob)

    assert_not_nil john_food
    assert_not_nil bob_food
    assert_not_equal john_food.id, bob_food.id
    assert_equal "Food", john_food.name
    assert_equal "Food", bob_food.name
  end

  test "should validate uniqueness of name scoped to user" do
    john = users(:john)

    # Try to create a duplicate category for the same user
    duplicate = Category.new(name: "Food", user: john)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "deleting user should delete their categories" do
    john = users(:john)
    john_category_ids = john.categories.pluck(:id)

    assert_difference "Category.count", -2 do
      john.destroy
    end

    john_category_ids.each do |id|
      assert_nil Category.find_by(id: id)
    end
  end
end
