# This is a feature spec for testing the Recipe#index view.

require 'rails_helper'

RSpec.describe 'Testing Recipe#index view, it', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, and create sample recipes.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user

    # Create a test recipe and five additional recipes.
    @recipe = Recipe.create(name: 'Test Recipe', description: 'Test Description',
                            preparation_time: 10, cooking_time: 10,
                            public: true, user_id: @user.id)
    5.times do |i|
      Recipe.create(name: "Recipe ##{i}", description: "Description ##{i}",
                    preparation_time: 10, cooking_time: 10,
                    public: false, user_id: @user.id)
    end

    # Visit the user's recipe index page.
    visit user_recipes_path(@user)
  end

  # Test: It should display the name of each of the recipes.
  it 'display the name of each of the recipes' do
    # Check for the presence of recipe names on the page.
    expect(page).to have_content(@recipe.name)
    5.times { |i| expect(page).to have_content("Recipe ##{i}") }
  end

  # Test: It should display the description of the recipes.
  it 'display the description of the recipes' do
    # Check for the presence of the description of the initial recipe on the page.
    expect(page).to have_content(@recipe.description)
  end

  # Test: It should display a button to add a new recipe.
  it 'display a button to add a new recipe' do
    # Check for the presence of a "New Recipe" button with the correct path.
    expect(page).to have_link('New Recipe', href: new_user_recipe_path(@user))
  end

  # Test: It should navigate to a new page when the "New Recipe" button is clicked.
  it 'navigate to a new page when the "New Recipe" button is clicked' do
    # Click the "New Recipe" button and check if the page navigates to the new recipe page.
    click_link('New Recipe', href: new_user_recipe_path(@user))
    expect(page).to have_current_path(new_user_recipe_path(@user))
  end
end
