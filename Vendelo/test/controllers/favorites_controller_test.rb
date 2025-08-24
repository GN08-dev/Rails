require "test_helper"
class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @product = products(:megadrive)
  end
  test "should create favorite" do
    assert_difference("Favorite.count", 1) do # checar si se esta creando un producto
      post favorites_url(product_id: @product.id)
    end
    assert_redirected_to product_path(@product)
  end

  test "get list of favorites" do
    get favorites_url
    assert_response :success
  end
end
