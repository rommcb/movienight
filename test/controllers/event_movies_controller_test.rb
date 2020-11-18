require 'test_helper'

class EventMoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get event_movies_edit_url
    assert_response :success
  end

  test "should get update" do
    get event_movies_update_url
    assert_response :success
  end

end
