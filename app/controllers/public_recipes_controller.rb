class PublicRecipesController < ApplicationController
  # Action to display a list of public recipes
  def index
    @p_recipes = Recipe.includes(:user).where(public: true).order(created_at: :desc)
  end
end
