class UsersControllerTest < ActionDispatch::IntegrationTest
 setup do
  @user = users(:prueba)
 end
  test "should get users products" do
    get user_url(@user.username)
    assert_response :success
  end
end
