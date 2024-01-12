# This is a feature spec for testing the Food#index view.

require 'rails_helper'

RSpec.describe 'Testing Food#index view, it should', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, and create sample foods.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user
    @food = Food.create(name: 'Test Food', measurement_unit: 'test', price: 10, user_id: @user.id)
    5.times { |i| Food.create(name: "Food ##{i}", measurement_unit: 'unit', price: 1, user_id: @user.id) }
    visit user_foods_path(@user)
  end

  # Test: It should display the name, measurement unit, and price of each of the foods.
  it 'display the name, measurement unit, and price of each of the foods' do
    # Check for the presence of food details for the initial food.
    expect(page).to have_content(@food.name)
    expect(page).to have_content(@food.measurement_unit)
    expect(page).to have_content(@food.price)

    # Check for the presence of food details for the additional foods.
    5.times { |i| expect(page).to have_content("Food ##{i}") }
  end

  # Test: It should display a button to add a new food and navigate to the new food page.
  it 'display a button to add a new food and navigate to a new page when clicked' do
    # Check for the presence of the "Add a food" button with the correct path.
    expect(page).to have_link('Add a food', href: new_user_food_path(@user))

    # Click the "Add a food" button and check if the page navigates to the new food page.
    click_link('Add a food', href: new_user_food_path(@user))
    expect(page).to have_current_path(new_user_food_path(@user))
  end
end
