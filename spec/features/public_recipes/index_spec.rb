# This is a feature spec for testing the PublicRecipe#index view.

require 'rails_helper'

RSpec.describe 'Testing PublicRecipe#index view, it', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, and create sample recipes.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user

    # Create a public recipe and several private recipes.
    @p_recipe = Recipe.create(name: 'Public Recipe', description: 'Test Description',
                              preparation_time: 10, cooking_time: 10,
                              public: true, user_id: @user.id)
    4.times do |i|
      Recipe.create(name: "Recipe ##{i}", description: "Description ##{i}",
                    preparation_time: 10, cooking_time: 10,
                    public: false, user_id: @user.id)
    end

    # Visit the public recipes path.
    visit public_recipes_path
  end

  # Test: It should display only the public recipe.
  it 'display only the public recipe' do
    expect(page).to have_content(@p_recipe.name)
  end

  # Test: It should display the public recipe description.
  it 'display the public recipe description' do
    expect(page).to have_content(@p_recipe.description)
  end

  # Test: It should display a remove button for the public recipe.
  it 'display a remove button for the public recipe' do
    expect(page).to have_button('Remove')
  end

  # Test: It should link the public recipe to its show page.
  it 'link the public recipe to its show page' do
    expect(page).to have_link(@p_recipe.name, href: user_recipe_path(@p_recipe.user, @p_recipe))
  end

  # Test: It should not allow other users to remove the public recipe if they are not the owner.
  it 'not allow other users to remove the public recipe if they are not the owner' do
    # Create a new user, confirm the user's account, sign in, and attempt to visit the public recipes path.
    new_user = User.create(name: 'User Test', email: 'test@example.com', password: '234567')
    new_user.confirm
    sign_in new_user
    visit public_recipes_path

    # Check that the 'Remove' button is disabled for the public recipe.
    expect(page).to have_button('Remove', disabled: true)
  end
end
