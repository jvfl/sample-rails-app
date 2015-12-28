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
    fill_in 'user_password', :with => '123456789!', :exact => true
    fill_in 'user_password_confirmation', :with => '123456789!'
    click_button 'Sign up'
    page.must_have_content 'Password is invalid'
  end

  test "user has to confirm via e-mail" do
    visit "/register"
    fill_in 'user_email', :with => 'test@ex.org'
    fill_in 'user_password', :with => 'ab123456789'
    fill_in 'user_password_confirmation', :with => 'ab123456789'
    click_button 'Sign up'
    page.must_have_content 'Log in'
    fill_in 'user_email', :with => 'test@ex.org'
    fill_in 'user_password', :with => 'ab123456789'
    click_button 'Log in'
    page.must_have_content 'You have to confirm your email address before continuing.'
  end

  test "confirmed user can view home page" do

    #Using the tom user from the fixtures. Password is hardcoded because there's no such field in the db.
    visit "/login"
    fill_in 'user_email', :with => users(:tom).email
    fill_in 'user_password', :with => '123456789ab'
    click_button 'Log in'
    page.must_have_content 'Signed in successfully.'
    # Logout so other tests can occur without problems
    click_link 'Log out'
  end

end
