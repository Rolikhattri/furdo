require 'test_helper'

class InstallmentsControllerTest < ActionController::TestCase
  setup do
    @installment = installments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:installments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create installment" do
    assert_difference('Installment.count') do
      post :create, installment: { amount: @installment.amount, due_date: @installment.due_date, payment_date: @installment.payment_date, status: @installment.status, user_id: @installment.user_id }
    end

    assert_redirected_to installment_path(assigns(:installment))
  end

  test "should show installment" do
    get :show, id: @installment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @installment
    assert_response :success
  end

  test "should update installment" do
    patch :update, id: @installment, installment: { amount: @installment.amount, due_date: @installment.due_date, payment_date: @installment.payment_date, status: @installment.status, user_id: @installment.user_id }
    assert_redirected_to installment_path(assigns(:installment))
  end

  test "should destroy installment" do
    assert_difference('Installment.count', -1) do
      delete :destroy, id: @installment
    end

    assert_redirected_to installments_path
  end
end
