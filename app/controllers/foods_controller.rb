class FoodsController < ApplicationController
  # Action to display a list of foods for a specific user
  def index
    @user = User.includes(:foods).find(params[:user_id])
    @food = @user.foods
  end

  # Action to render a form for creating a new food
  def new
    @user = current_user
    @food = @user.foods.build
  end

  # Action to create a new food
  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to user_foods_path(current_user)
    else
      render :new
    end
  end

  # Action to destroy a food and its associations in recipe foods
  def destroy
    @food = current_user.foods.find(params[:id])
    RecipeFood.where(food_id: @food.id).destroy_all
    @food.destroy
    redirect_to user_foods_path(current_user), notice: 'Food successfully deleted'
  end

  private

  # Strong parameters to whitelist and require for food creation
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
