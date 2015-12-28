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
    fill_in 'Email', :with => 'test2@ex.org'
    fill_in 'Password', :with => '123456789!'
    fill_in 'Password confirmation', :with => '123456789!'
    click_button 'Sign up'
    page.must_have_content 'Password is invalid'
  end

  test "user has to confirm via e-mail" do
    visit "/register"
    fill_in 'Email', :with => 'test@ex.org'
    fill_in 'Password', :with => 'ab123456789'
    fill_in 'Password confirmation', :with => 'ab123456789'
    click_button 'Sign up'
    page.must_have_content 'Log in'
    fill_in 'Email', :with => 'test@ex.org'
    fill_in 'Password', :with => 'ab123456789'
    click_button 'Log in'
    page.must_have_content 'You have to confirm your email address before continuing.'
  end

  test "confirmed user can view home page" do

    #Using the tom user from the fixtures. Password is hardcoded because there's no such field in the db.
    visit "/login"
    fill_in 'Email', :with => users(:tom).email
    fill_in 'Password', :with => '123456789ab'
    click_button 'Log in'
    page.must_have_content 'Signed in successfully.'

    # Logout so other tests can occur without problems
    click_link 'Logout'
  end

end
