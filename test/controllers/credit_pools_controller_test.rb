require "test_helper"

class CreditPoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credit_pool = credit_pools(:one)
  end

  test "should get index" do
    get credit_pools_url
    assert_response :success
  end

  test "should get new" do
    get new_credit_pool_url
    assert_response :success
  end

  test "should create credit_pool" do
    assert_difference("CreditPool.count") do
      post credit_pools_url, params: { credit_pool: { credits: @credit_pool.credits } }
    end

    assert_redirected_to credit_pool_url(CreditPool.last)
  end

  test "should show credit_pool" do
    get credit_pool_url(@credit_pool)
    assert_response :success
  end

  test "should get edit" do
    get edit_credit_pool_url(@credit_pool)
    assert_response :success
  end

  test "should update credit_pool" do
    patch credit_pool_url(@credit_pool), params: { credit_pool: { credits: @credit_pool.credits } }
    assert_redirected_to credit_pool_url(@credit_pool)
  end

  test "should destroy credit_pool" do
    assert_difference("CreditPool.count", -1) do
      delete credit_pool_url(@credit_pool)
    end

    assert_redirected_to credit_pools_url
  end
end
