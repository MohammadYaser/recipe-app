# This is a feature spec for testing the RecipeFood#new view.

require 'rails_helper'

RSpec.describe 'Testing RecipeFood#new view, it', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, create a recipe, and visit the new recipe_food page.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user

    # Create a test recipe and a test food.
    @recipe = Recipe.create(name: 'Recipe', description: 'Test Description',
                            preparation_time: 10, cooking_time: 10,
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Test Food', measurement_unit: 'test', price: 10, user_id: @user.id)

    # Visit the new recipe_food page for the given recipe.
    visit new_user_recipe_recipe_food_path(@user, @recipe)
  end

  # Test: It should display a form to add a new recipe food.
  it 'display a form to add a new recipe food' do
    # Check for the presence of form fields and the 'Add Ingredient' button.
    expect(page).to have_field('recipe_food_food_id')
    expect(page).to have_field('recipe_food_quantity')
    expect(page).to have_button('Add Ingredient')
  end

  # Test: It should be able to add a new item.
  it 'should be able to add a new item' do
    # Check for the presence of the 'Add Ingredient' button.
    expect(page).to have_button('Add Ingredient')
  end

  # Test: It should add a food to the recipe when the form is submitted.
  it 'add a food to the recipe when the form is submitted' do
    # Fill in the form fields, click 'Add Ingredient',
    # and check for the expected redirection and content on the recipe page.
    select(@food.name, from: 'Food')
    fill_in('recipe_food_quantity', with: 10)
    click_button('Add Ingredient')
    expect(page).to have_current_path(user_recipe_path(@user, @recipe))
    expect(page).to have_content('Test Food')
  end
end
