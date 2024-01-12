# This is a unit test for the User model using RSpec.

require 'rails_helper'

RSpec.describe User, type: :model do
  # Setup: Create a User instance with valid attributes before each test.
  before do
    @user = User.new(name: 'Test User', email: 'test@example.com', password: 'password',
                     password_confirmation: 'password')
  end

  # Test: The User is valid with valid attributes.
  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  # Test: The User is not valid without a name.
  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  # Test: The User is not valid without an email.
  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  # Test: The User is not valid without a password.
  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end
end
