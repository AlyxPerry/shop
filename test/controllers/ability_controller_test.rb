require 'test_helper'

class AbilityControllerTest < ActionDispatch::IntegrationTest
  test "should get user_ability" do
    get ability_user_ability_url
    assert_response :success
  end

end
