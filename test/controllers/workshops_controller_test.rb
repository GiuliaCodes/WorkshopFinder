require "test_helper"

class WorkshopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workshop = workshops(:one)
  end

  test "should get index" do
    get workshops_url
    assert_response :success
  end

  test "should get new" do
    get new_workshop_url
    assert_response :success
  end

  test "should create workshop" do
    assert_difference('Workshop.count') do
      post workshops_url, params: { workshop: { category: @workshop.category, city: @workshop.city, date: @workshop.date, description: @workshop.description, length: @workshop.length, location: @workshop.location, max_partecipants: @workshop.max_partecipants, name: @workshop.name, price: @workshop.price, time: @workshop.time } }
    end

    assert_redirected_to workshop_url(Workshop.last)
  end

  test "should show workshop" do
    get workshop_url(@workshop)
    assert_response :success
  end

  test "should get edit" do
    get edit_workshop_url(@workshop)
    assert_response :success
  end

  test "should update workshop" do
    patch workshop_url(@workshop), params: { workshop: { category: @workshop.category, city: @workshop.city, date: @workshop.date, description: @workshop.description, length: @workshop.length, location: @workshop.location, max_partecipants: @workshop.max_partecipants, name: @workshop.name, price: @workshop.price, time: @workshop.time } }
    assert_redirected_to workshop_url(@workshop)
  end

  test "should destroy workshop" do
    assert_difference('Workshop.count', -1) do
      delete workshop_url(@workshop)
    end

    assert_redirected_to workshops_url
  end
end
