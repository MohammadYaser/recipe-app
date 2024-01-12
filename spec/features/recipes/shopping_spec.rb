# This is a feature spec for testing the Recipe#show view.

require 'rails_helper'

RSpec.describe 'Testing Recipe#show view, it', type: :feature do
  before(:each) do
    # Setup: Create two users, confirm their accounts, sign in the first user, and create a recipe, food, and recipe_food.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user2 = User.create(name: 'User Test', email: 'test@example.com', password: '234567')
    @user.confirm
    sign_in @user

    # Create a recipe, food, and a related recipe_food.
    @recipe = Recipe.create(name: 'Test Recipe', description: 'Test Description',
                            preparation_time: 10, cooking_time: 10,
                            public: false, user_id: @user.id)
    @food = Food.create(name: 'Test Food', measurement_unit: 'test', price: 10, user_id: @user2.id)
    @food2 = Food.create(name: 'Food #2', measurement_unit: 'unit', price: 1, user_id: @user.id)

    # Create a recipe_food related to the initial recipe.
    @recipe_food = RecipeFood.create(recipe_id: @recipe.id, food_id: @food.id, quantity: 10)

    # Visit the recipe show page, add an ingredient, and generate the shopping list.
    visit user_recipe_path(@user, @recipe)
    click_button('Add ingredients')
    select(@food2.name, from: 'Food')
    fill_in('recipe_food_quantity', with: 10)
    click_button('Add Ingredient')
  end

  # Test: It should visit the shopping list and display the correct information.
  it 'should visit the shopping list' do
    # Click the 'Generate Shopping List' button and check for the expected content on the shopping list page.
    click_button('Generate Shopping List')
    expect(page).to have_content('Total food items: 1')
    expect(page).to have_content('Total price: $100')
    expect(page).to have_content('Test Food 10 test')
  end
end
