require "application_system_test_case"

class PowerOfAttorneysTest < ApplicationSystemTestCase
  setup do
    @power_of_attorney = power_of_attorneys(:one)
  end

  test "visiting the index" do
    visit power_of_attorneys_url
    assert_selector "h1", text: "Power of attorneys"
  end

  test "should create power of attorney" do
    visit power_of_attorneys_url
    click_on "New power of attorney"

    fill_in "Employee", with: @power_of_attorney.employee_id
    fill_in "End date", with: @power_of_attorney.end_date
    fill_in "Title", with: @power_of_attorney.title
    click_on "Create Power of attorney"

    assert_text "Power of attorney was successfully created"
    click_on "Back"
  end

  test "should update Power of attorney" do
    visit power_of_attorney_url(@power_of_attorney)
    click_on "Edit this power of attorney", match: :first

    fill_in "Employee", with: @power_of_attorney.employee_id
    fill_in "End date", with: @power_of_attorney.end_date
    fill_in "Title", with: @power_of_attorney.title
    click_on "Update Power of attorney"

    assert_text "Power of attorney was successfully updated"
    click_on "Back"
  end

  test "should destroy Power of attorney" do
    visit power_of_attorney_url(@power_of_attorney)
    click_on "Destroy this power of attorney", match: :first

    assert_text "Power of attorney was successfully destroyed"
  end
end
