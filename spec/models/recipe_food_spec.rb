# This is a unit test for the RecipeFood model using RSpec.

require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  # Setup: Create a User instance, a Recipe instance, a Food instance, and a RecipeFood instance
  # with valid attributes before each test.
  before(:each) do
    @user = User.create(email: 'sadaf@example.com', password: 'password')
    @recipe = Recipe.new(
      name: 'Apple',
      preparation_time: 30,
      cooking_time: 40,
      description: 'something.....',
      public: true,
      user: @user
    )
    @food = Food.new(
      name: 'Apple',
      quantity: 200
    )
    @recipe_food = RecipeFood.new(
      quantity: 200,
      recipe: @recipe,
      food: @food
    )
  end

  # Describe block for validations.
  describe 'validations' do
    # Test: The RecipeFood is valid with valid attributes.
    it 'is valid with valid attributes' do
      expect(@recipe_food).to be_valid
    end

    # Test: The RecipeFood is not valid without a quantity.
    it 'is not valid without a quantity' do
      @recipe_food.quantity = nil
      expect(@recipe_food).to_not be_valid
    end

    # Test: The RecipeFood is not valid with a non-positive quantity.
    it 'is not valid with a non-positive quantity' do
      @recipe_food.quantity = -1
      expect(@recipe_food).to_not be_valid
    end
  end
end
