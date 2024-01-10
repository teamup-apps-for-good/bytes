require "application_system_test_case"

class CreditPoolsTest < ApplicationSystemTestCase
  setup do
    @credit_pool = credit_pools(:one)
  end

  test "visiting the index" do
    visit credit_pools_url
    assert_selector "h1", text: "Credit pools"
  end

  test "should create credit pool" do
    visit credit_pools_url
    click_on "New credit pool"

    fill_in "Credits", with: @credit_pool.credits
    click_on "Create Credit pool"

    assert_text "Credit pool was successfully created"
    click_on "Back"
  end

  test "should update Credit pool" do
    visit credit_pool_url(@credit_pool)
    click_on "Edit this credit pool", match: :first

    fill_in "Credits", with: @credit_pool.credits
    click_on "Update Credit pool"

    assert_text "Credit pool was successfully updated"
    click_on "Back"
  end

  test "should destroy Credit pool" do
    visit credit_pool_url(@credit_pool)
    click_on "Destroy this credit pool", match: :first

    assert_text "Credit pool was successfully destroyed"
  end
end
