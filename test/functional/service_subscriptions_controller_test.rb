require 'test_helper'

class ServiceSubscriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_subscription" do
    assert_difference('ServiceSubscription.count') do
      post :create, :service_subscription => { }
    end

    assert_redirected_to service_subscription_path(assigns(:service_subscription))
  end

  test "should show service_subscription" do
    get :show, :id => service_subscriptions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => service_subscriptions(:one).to_param
    assert_response :success
  end

  test "should update service_subscription" do
    put :update, :id => service_subscriptions(:one).to_param, :service_subscription => { }
    assert_redirected_to service_subscription_path(assigns(:service_subscription))
  end

  test "should destroy service_subscription" do
    assert_difference('ServiceSubscription.count', -1) do
      delete :destroy, :id => service_subscriptions(:one).to_param
    end

    assert_redirected_to service_subscriptions_path
  end
end
