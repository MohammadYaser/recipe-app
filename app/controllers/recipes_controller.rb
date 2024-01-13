class RecipesController < ApplicationController
  # Action to display a list of recipes for a specific user
  def index
    @user = User.find(params[:user_id])
    @recipes = @user.recipes
  end

  # Action to show details of a specific recipe
  def show
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  # Action to render a form for creating a new recipe
  def new
    @user = current_user
    @recipe = @user.recipes.build
  end

  # Action to create a new recipe
  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to user_recipes_path(current_user)
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  # Action to destroy a recipe and its associated recipe foods
  def destroy
    @recipe = current_user.recipes.includes(:recipe_foods).find(params[:id])
    RecipeFood.where(recipe_id: @recipe.id).destroy_all
    @recipe.destroy

    redirect_to request.referrer, notice: 'Recipe was successfully destroyed.'
  end

  # Action to update the details of a recipe
  def update
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(@user, @recipe), notice: 'Recipe was successfully updated.'
    else
      render :show
    end
  end

  # Action to generate a shopping list for a recipe
  def shopping_list
    @recipe = Recipe.includes([recipe_foods: [:food]]).find(params[:id])
    user_foods = current_user.foods


    missing_foods = @recipe.recipe_foods.reject { |recipe_food| user_foods.include?(recipe_food.food) }

    @data = {
      total_items: missing_foods.size,
      total_price: missing_foods.sum { |recipe_food| recipe_food.quantity * recipe_food.food.price }
    }
    @missing_foods = missing_foods

    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
    @total = @recipe_foods.sum { |recipe_food| recipe_food.quantity * recipe_food.food.price }
    @count_of_items = @recipe_foods.count
  end

  private

  # Define permitted parameters for recipe
  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
