require 'test_helper'

class DebfilesControllerTest < ActionController::TestCase
  setup do
    @debfile = debfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debfile" do
    assert_difference('Debfile.count') do
      post :create, debfile: { control: @debfile.control, name: @debfile.name, version: @debfile.version }
    end

    assert_redirected_to debfile_path(assigns(:debfile))
  end

  test "should show debfile" do
    get :show, id: @debfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debfile
    assert_response :success
  end

  test "should update debfile" do
    patch :update, id: @debfile, debfile: { control: @debfile.control, name: @debfile.name, version: @debfile.version }
    assert_redirected_to debfile_path(assigns(:debfile))
  end

  test "should destroy debfile" do
    assert_difference('Debfile.count', -1) do
      delete :destroy, id: @debfile
    end

    assert_redirected_to debfiles_path
  end
end
