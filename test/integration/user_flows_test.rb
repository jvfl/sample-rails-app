require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  #Adding capybara DSL and its minitest extension. 
  include Capybara::DSL
  ActionDispatch::IntegrationTest.extend Minitest::Spec::DSL
  
  test "root redirects to login page" do
    get "/"
    assert_redirected_to "/login"
  end

  test "home redirects to login page" do
    get "/home"
    assert_redirected_to "/login"
  end

  test "alphanumeric passwords only" do
  	visit "/register"
    fill_in 'user_email', :with => 'test2@ex.org'
    fill_in 'user_password', :with => '123456789!'
    fill_in 'user_password_confirmation', :with => '123456789!'
    click_button I18n.t(:signup)
    page.must_have_content I18n.t(:'activerecord.errors.models.user.attributes.password.invalid')
  end

  test "user has to confirm via e-mail" do
    visit "/register"
    fill_in 'user_email', :with => 'test@ex.org'
    fill_in 'user_password', :with => 'ab123456789'
    fill_in 'user_password_confirmation', :with => 'ab123456789'
    click_button I18n.t(:signup)
    page.must_have_content I18n.t(:login)
    fill_in 'user_email', :with => 'test@ex.org'
    fill_in 'user_password', :with => 'ab123456789'
    click_button I18n.t(:login)
    page.must_have_content I18n.t(:'devise.failure.unconfirmed')
  end

  test "confirmed user can view home page" do

    #Using the tom user from the fixtures. Password is hardcoded because there's no such field in the db.
    visit "/login"
    fill_in 'user_email', :with => users(:tom).email
    fill_in 'user_password', :with => '123456789ab'
    click_button I18n.t(:login)
    page.must_have_content I18n.t(:'devise.sessions.signed_in')
    # Logout so other tests can occur without problems
    click_link I18n.t(:logout)
  end

end
