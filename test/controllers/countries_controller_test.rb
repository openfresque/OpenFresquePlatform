require "test_helper"

class CountriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @country = countries(:one)
  end

  test "should get index" do
    get countries_url
    assert_response :success
  end

  test "should get new" do
    get new_country_url
    assert_response :success
  end

  test "should create country" do
    assert_difference("Country.count") do
      post countries_url, params: { country: { code: @country.code, currency_code: @country.currency_code, currency_name: @country.currency_name, external_id: @country.external_id, name: @country.name, tax_rate: @country.tax_rate } }
    end

    assert_redirected_to country_url(Country.last)
  end

  test "should show country" do
    get country_url(@country)
    assert_response :success
  end

  test "should get edit" do
    get edit_country_url(@country)
    assert_response :success
  end

  test "should update country" do
    patch country_url(@country), params: { country: { code: @country.code, currency_code: @country.currency_code, currency_name: @country.currency_name, external_id: @country.external_id, name: @country.name, tax_rate: @country.tax_rate } }
    assert_redirected_to country_url(@country)
  end

  test "should destroy country" do
    assert_difference("Country.count", -1) do
      delete country_url(@country)
    end

    assert_redirected_to countries_url
  end
end
