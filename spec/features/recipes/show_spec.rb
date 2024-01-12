# This is a feature spec for testing the Recipe#show view.

require 'rails_helper'

RSpec.describe 'Testing Recipe#show view, it', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, and create a recipe.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user

    # Create a test recipe and visit its show page.
    @recipe = Recipe.create(name: 'Test Recipe', description: 'Test Description',
                            preparation_time: 10, cooking_time: 10,
                            public: false, user_id: @user.id)
    visit user_recipe_path(@user, @recipe)
  end

  # Test: It should display the name of the recipe.
  it 'should display the name of the recipe' do
    # Check for the presence of the recipe name on the page.
    expect(page).to have_content(@recipe.name)
  end

  # Test: It should display the description of the recipe.
  it 'should display the description of the recipe' do
    # Check for the presence of the recipe description on the page.
    expect(page).to have_content(@recipe.description)
  end

  # Test: It should display the preparation time of the recipe.
  it 'should display the preparation time of the recipe' do
    # Check for the presence of the recipe preparation time on the page.
    expect(page).to have_content(@recipe.preparation_time)
  end

  # Test: It should display the cooking time of the recipe.
  it 'should display the cooking time of the recipe' do
    # Check for the presence of the recipe cooking time on the page.
    expect(page).to have_content(@recipe.cooking_time)
  end

  # Test: It should have a checkbox to mark the recipe as public, and it should change when enabled.
  it 'should have a checkbox to mark the recipe as public, and it should change when enabled' do
    # Check for the presence and state of the public checkbox.
    expect(page).to have_field('recipe_public')
    expect(page).to have_unchecked_field('recipe_public')
    check('recipe_public')
    expect(page).to have_checked_field('recipe_public')
  end

  # Test: It should have a button to add an ingredient.
  it 'should have a button to add an ingredient' do
    # Check for the presence of the 'Add ingredients' button.
    expect(page).to have_button('Add ingredients')
  end

  # Test: It should have a button to generate a shopping list.
  it 'should have a button to generate a shopping list' do
    # Check for the presence of the 'Generate Shopping List' button.
    expect(page).to have_button('Generate Shopping List')
  end
end
