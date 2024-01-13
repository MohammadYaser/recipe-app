# This is a feature spec for testing the Food#new view.

require 'rails_helper'

RSpec.describe 'Testing Food#new view, it', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, and visit the new food form.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user
    visit new_user_food_path(@user)
  end

  # Test: It should display a form to create a new food.
  it 'display a form to create a new food' do
    expect(page).to have_field('food_name')
    expect(page).to have_field('food_measurement_unit')
    expect(page).to have_field('food_price')
    expect(page).to have_button('Create Food')
  end

  # Test: It should create a new food when the form is submitted.
  it 'create a new food when the form is submitted' do
    # Fill in the form fields, submit the form, and check for the expected outcome.
    fill_in('food_name', with: 'Test Food')
    select('mg', from: 'food_measurement_unit')
    fill_in('food_price', with: 10)
    click_button('Create Food')

    # Expectations after submitting the form.
    expect(page).to have_current_path(user_foods_path(@user))
    expect(page).to have_content('Test Food')
  end
end
