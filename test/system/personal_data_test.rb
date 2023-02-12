require "application_system_test_case"

class PersonalDataTest < ApplicationSystemTestCase
  setup do
    @personal_datum = personal_data(:one)
  end

  test "visiting the index" do
    visit personal_data_url
    assert_selector "h1", text: "Personal data"
  end

  test "should create personal datum" do
    visit personal_data_url
    click_on "New personal datum"

    fill_in "Birth", with: @personal_datum.birth
    fill_in "Code", with: @personal_datum.code
    fill_in "Date of birth", with: @personal_datum.date_of_birth
    fill_in "Date of issue", with: @personal_datum.date_of_issue
    fill_in "Email", with: @personal_datum.email
    fill_in "Employee", with: @personal_datum.employee_id
    fill_in "Inn", with: @personal_datum.inn
    fill_in "Issued by", with: @personal_datum.issued_by
    fill_in "Passport n", with: @personal_datum.passport_n
    fill_in "Passport s", with: @personal_datum.passport_s
    fill_in "Phone number", with: @personal_datum.phone_number
    fill_in "Place of ", with: @personal_datum.place_of_
    fill_in "Snils", with: @personal_datum.snils
    click_on "Create Personal datum"

    assert_text "Personal datum was successfully created"
    click_on "Back"
  end

  test "should update Personal datum" do
    visit personal_datum_url(@personal_datum)
    click_on "Edit this personal datum", match: :first

    fill_in "Birth", with: @personal_datum.birth
    fill_in "Code", with: @personal_datum.code
    fill_in "Date of birth", with: @personal_datum.date_of_birth
    fill_in "Date of issue", with: @personal_datum.date_of_issue
    fill_in "Email", with: @personal_datum.email
    fill_in "Employee", with: @personal_datum.employee_id
    fill_in "Inn", with: @personal_datum.inn
    fill_in "Issued by", with: @personal_datum.issued_by
    fill_in "Passport n", with: @personal_datum.passport_n
    fill_in "Passport s", with: @personal_datum.passport_s
    fill_in "Phone number", with: @personal_datum.phone_number
    fill_in "Place of ", with: @personal_datum.place_of_
    fill_in "Snils", with: @personal_datum.snils
    click_on "Update Personal datum"

    assert_text "Personal datum was successfully updated"
    click_on "Back"
  end

  test "should destroy Personal datum" do
    visit personal_datum_url(@personal_datum)
    click_on "Destroy this personal datum", match: :first

    assert_text "Personal datum was successfully destroyed"
  end
end
