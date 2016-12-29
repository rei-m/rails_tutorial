require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "test1",
                                          email: "test1@test.test",
                                          password: "foobar",
                                          password_confirmation: "foobar"} }
    end
    # これがないとリダイレクトされない
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert-success'
  end

  test "invalid signup information" do
     get signup_path
     assert_select 'form[action="/signup"]'
     assert_no_difference 'User.count' do
       post signup_path, params: { user: { name:  "",
                                          email: "user@invalid",
                                          password:              "foo",
                                          password_confirmation: "bar" } }
     end

     assert_template 'users/new'
     assert_select 'div#error_explanation div', "The form contains 4 errors."
  end
end
