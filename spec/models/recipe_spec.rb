# This is a unit test for the Recipe model using RSpec.

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  # Setup: Create a User instance and a Recipe instance with valid attributes before each test.
  before(:each) do
    @user = User.create(email: 'sadaf@example.com', password: 'password')
    @recipe = Recipe.new(
      name: 'Apple',
      preparation_time: 30,
      cooking_time: 40,
      description: 'something about apple',
      public: true,
      user: @user
    )
  end

  # Describe block for validations.
  describe 'validations' do
    # Test: The Recipe is valid with valid attributes.
    it 'is valid with valid attributes' do
      expect(@recipe).to be_valid
    end

    # Test: The Recipe is not valid without a name.
    it 'is not valid without a name' do
      @recipe.name = nil
      expect(@recipe).to_not be_valid
    end

    # Test: The Recipe is not valid without a preparation time.
    it 'is not valid without a preparation time' do
      @recipe.preparation_time = nil
      expect(@recipe).to_not be_valid
    end

    # Test: The Recipe is not valid with a non-positive preparation time.
    it 'is not valid with a non-positive preparation time' do
      @recipe.preparation_time = -1
      expect(@recipe).to_not be_valid
    end

    # Test: The Recipe is not valid without a cooking time.
    it 'is not valid without a cooking time' do
      @recipe.cooking_time = nil
      expect(@recipe).to_not be_valid
    end

    # Test: The Recipe is not valid with a non-positive cooking time.
    it 'is not valid with a non-positive cooking time' do
      @recipe.cooking_time = -1
      expect(@recipe).to_not be_valid
    end

    # Test: The Recipe is not valid without a description.
    it 'is not valid without a description' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    # Test: The Recipe is not valid without a public status.
    it 'is not valid without a public' do
      @recipe.public = nil
      expect(@recipe).to_not be_valid
    end
  end
end
