require 'test_helper'

class UserSettingsControllerTest < ActionController::TestCase
  setup do
    @user_setting = user_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_setting" do
    assert_difference('UserSetting.count') do
      post :create, user_setting: @user_setting.attributes
    end

    assert_redirected_to user_setting_path(assigns(:user_setting))
  end

  test "should show user_setting" do
    get :show, id: @user_setting.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_setting.to_param
    assert_response :success
  end

  test "should update user_setting" do
    put :update, id: @user_setting.to_param, user_setting: @user_setting.attributes
    assert_redirected_to user_setting_path(assigns(:user_setting))
  end

  test "should destroy user_setting" do
    assert_difference('UserSetting.count', -1) do
      delete :destroy, id: @user_setting.to_param
    end

    assert_redirected_to user_settings_path
  end
end
