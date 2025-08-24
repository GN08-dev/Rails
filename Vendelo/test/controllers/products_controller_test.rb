require "test_helper"
class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  test "render a list of products" do
    get products_path # peticion a la url

    assert_response :success
    # buscar despues de la respuesta los productos
    assert_select ".product", 20
    assert_select ".category", 9
  end
  # percion a index para filtrado
  test "render a list of products filtered by category" do
    get products_path(category_id: categories(:computers).id)

    assert_response :success
    assert_select ".product", 5
  end
  test "render a list of products filtered by max_price and min_price" do
    get products_path(min_price: 150, max_price: 200)

    assert_response :success
    assert_select ".product", 5
    assert_select "h2", "PS4 Fat"
  end

  # testing by filter of text
  test "search a product by search_text " do
    get products_path(query_test: "ps4")

    assert_response :success
    assert_select ".product", 20
    assert_select "h2", "PS4 Fat"
  end
  test "render a details product page" do
        get product_path(products(:ps4))
        assert_response :success
        assert_select ".title", "PS4 Fat" # esto busca clases
  end

  # testing de la vista new
  test "allow to create a new product" do
    post products_path, params: {
      product: {
        title: "Nitendo",
        descripcion: "Nuevo",
        price: 45,
        category_id: categories(:videogames).id
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t("products.create.created")
  end

  # testing del filter por select
  test "sort products by expensive prices first" do
    get products_path(order_by: "expensive")

    assert_response :success
    assert_select ".product", 20
    # se hizo una peticion query en la consola web para saber cual era
    # document.querySelector(".product:first-child h2")
    assert_select ".product:first-child h2", "Seat Panda clásico"
  end

  # testing para la vista de edith
  test "render an edit product from" do
    get edit_product_path(products(:ps4))
    assert_response :success
    assert_select "form"
  end

  # update
  test "allows to update a pr oduct" do
    patch product_path(products(:xbox)), params: {
      product: {
        price: 600
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t("products.update.updated")
  end

   # prueba de error de update
   test "does not allow to update a product with an invalid field" do
    patch product_path(products(:xbox)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end

  # prueba de eliminacion de producto
  test "can delete product" do
    assert_difference("Product.count", -1) do
    delete product_path(products(:ps4))
    end
    assert_redirected_to products_path
    assert_equal flash[:notice], I18n.t("products.destroy.destroyed")
  end
end
