# This is a feature spec for testing the User#index view.

require 'rails_helper'

RSpec.describe 'Testing User#index view, it', type: :feature do
  before(:each) do
    # Setup: Create a user, confirm the user's account, sign in, and visit the root path.
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
    @user.confirm
    sign_in @user
    visit root_path
  end

  # Test: It should greet the user on the index view.
  it 'should greet the user' do
    # Check for the presence of a personalized greeting for the user.
    expect(page).to have_content("Hello, #{@user.name}! Welcome to our wonderful app.")
  end
end
