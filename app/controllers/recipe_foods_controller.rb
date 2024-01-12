class RecipeFoodsController < ApplicationController
  before_action :set_user_and_recipe

  # Action to display a list of all recipe foods
  def index
    @recipe_foods = RecipeFood.all
  end

  # Action to show details of a specific recipe food
  def show
    @recipe_foods = RecipeFood.find_by_id(params[:id])

    # Redirect to the index page if the recipe food is not found
    return unless @recipe_foods.nil?

    redirect_to recipe_foods_path
  end

  # Action to render a form for adding a new recipe food
  def new
    @recipe_food = RecipeFood.new
  end

  # Action to create a new recipe food
  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to user_recipe_path(@user, @recipe), notice: 'Ingredient added successfully.'
    else
      render :new
    end
  end

  # Action to destroy a recipe food
  def destroy
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @recipe_food.destroy
    redirect_to user_recipe_path(@user, @recipe), notice: 'Ingredient successfully deleted'
  end

  private

  # Set user and recipe based on parameters
  def set_user_and_recipe
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
  end

  # Define permitted parameters for recipe food
  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
