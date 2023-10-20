require "test_helper"

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate = certificates(:one)
  end

  test "should get index" do
    get certificates_url
    assert_response :success
  end

  test "should get new" do
    get new_certificate_url
    assert_response :success
  end

  test "should create certificate" do
    assert_difference("Certificate.count") do
      post certificates_url, params: { certificate: { e_service: @certificate.e_service, employee_id: @certificate.employee_id, end_date: @certificate.end_date, legal_entity: @certificate.legal_entity, request_link: @certificate.request_link, request_number: @certificate.request_number, status: @certificate.status } }
    end

    assert_redirected_to certificate_url(Certificate.last)
  end

  test "should show certificate" do
    get certificate_url(@certificate)
    assert_response :success
  end

  test "should get edit" do
    get edit_certificate_url(@certificate)
    assert_response :success
  end

  test "should update certificate" do
    patch certificate_url(@certificate), params: { certificate: { e_service: @certificate.e_service, employee_id: @certificate.employee_id, end_date: @certificate.end_date, legal_entity: @certificate.legal_entity, request_link: @certificate.request_link, request_number: @certificate.request_number, status: @certificate.status } }
    assert_redirected_to certificate_url(@certificate)
  end

  test "should destroy certificate" do
    assert_difference("Certificate.count", -1) do
      delete certificate_url(@certificate)
    end

    assert_redirected_to certificates_url
  end
end
