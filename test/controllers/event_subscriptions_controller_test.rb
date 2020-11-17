require 'test_helper'

class EventSubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_subscriptions_create_url
    assert_response :success
  end

end
