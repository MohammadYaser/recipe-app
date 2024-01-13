# This is a unit test for the Food model using RSpec.

require 'rails_helper'

RSpec.describe Food, type: :model do
  # Describe block for validations.
  describe 'validations' do
    # Test: The Food is valid with valid attributes.
    it 'is valid with valid attributes' do
      user = User.create(email: 'sadaf@example.com', password: 'password')
      food = Food.new(
        name: 'Apple',
        measurement_unit: 'kg',
        price: 244,
        quantity: 200,
        user: user
      )

      expect(food).to be_valid
    end

    # Test: The Food is not valid without a name.
    it 'is not valid without a name' do
      food = Food.new(name: nil)
      expect(food).to_not be_valid
    end

    # Test: The Food is not valid without a measurement unit.
    it 'is not valid without a measurement unit' do
      food = Food.new(measurement_unit: nil)
      expect(food).to_not be_valid
    end

    # Test: The Food is not valid without a price.
    it 'is not valid without a price' do
      food = Food.new(price: nil)
      expect(food).to_not be_valid
    end

    # Test: The Food is not valid with a non-positive price.
    it 'is not valid with a non-positive price' do
      food = Food.new(price: -1)
      expect(food).to_not be_valid
    end

    # Test: The Food is not valid without a quantity.
    it 'is not valid without a quantity' do
      food = Food.new(quantity: nil)
      expect(food).to_not be_valid
    end

    # Test: The Food is not valid with a negative quantity.
    it 'is not valid with a negative quantity' do
      food = Food.new(quantity: -1)
      expect(food).to_not be_valid
    end
  end
end
