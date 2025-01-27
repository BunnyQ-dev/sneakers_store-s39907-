require "test_helper"

class SneakersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sneakers_index_url
    assert_response :success
  end

  test "should get show" do
    get sneakers_show_url
    assert_response :success
  end

  test "should get new" do
    get sneakers_new_url
    assert_response :success
  end

  test "should get create" do
    get sneakers_create_url
    assert_response :success
  end

  test "should get edit" do
    get sneakers_edit_url
    assert_response :success
  end

  test "should get update" do
    get sneakers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get sneakers_destroy_url
    assert_response :success
  end
end
