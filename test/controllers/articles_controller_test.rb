require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get articles_top_url
    assert_response :success
  end
end
