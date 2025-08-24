require "test_helper"
class Authentication::UsersControllerTest < ActionDispatch::Integration
  test "should get new" do
    get new_user_url
    assert_respond_to :success
  end
  test "should create  user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "prueba@vendol.com", username: "prueba", password: "testme" } }
    end
    assert_redirected_to products_path
  end
end
