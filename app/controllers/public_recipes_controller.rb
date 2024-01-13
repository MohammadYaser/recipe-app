class PublicRecipesController < ApplicationController
  # Action to display a list of public recipes
  def index
    @p_recipes = Recipe.includes(:user).where(public: true).order(created_at: :desc)

    @total = 0
    @count_of_items = 0

    # Loop through each recipe in @p_recipes
    @p_recipes.each do |recipe|
      recipe_foods = recipe.recipe_foods.includes(:food)
      @total += recipe_foods.sum { |recipe_food| recipe_food.quantity * recipe_food.food.price }
      @count_of_items += recipe_foods.count
    end
  end
end
