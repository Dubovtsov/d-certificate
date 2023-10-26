require "test_helper"

class PowerOfAttorneysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @power_of_attorney = power_of_attorneys(:one)
  end

  test "should get index" do
    get power_of_attorneys_url
    assert_response :success
  end

  test "should get new" do
    get new_power_of_attorney_url
    assert_response :success
  end

  test "should create power_of_attorney" do
    assert_difference("PowerOfAttorney.count") do
      post power_of_attorneys_url, params: { power_of_attorney: { employee_id: @power_of_attorney.employee_id, end_date: @power_of_attorney.end_date, title: @power_of_attorney.title } }
    end

    assert_redirected_to power_of_attorney_url(PowerOfAttorney.last)
  end

  test "should show power_of_attorney" do
    get power_of_attorney_url(@power_of_attorney)
    assert_response :success
  end

  test "should get edit" do
    get edit_power_of_attorney_url(@power_of_attorney)
    assert_response :success
  end

  test "should update power_of_attorney" do
    patch power_of_attorney_url(@power_of_attorney), params: { power_of_attorney: { employee_id: @power_of_attorney.employee_id, end_date: @power_of_attorney.end_date, title: @power_of_attorney.title } }
    assert_redirected_to power_of_attorney_url(@power_of_attorney)
  end

  test "should destroy power_of_attorney" do
    assert_difference("PowerOfAttorney.count", -1) do
      delete power_of_attorney_url(@power_of_attorney)
    end

    assert_redirected_to power_of_attorneys_url
  end
end
