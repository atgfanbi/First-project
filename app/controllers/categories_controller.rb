class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    if(@category.user_id != current_user.id)
      redirect_to categories_path
    end
  end

  def edit
    @category = Category.find(params[:id])
    if(@category.user_id != current_user.id)
      redirect_to categories_path
    end
  end

  def update
    @category = Category.find(params[:id])
    if(@category.user_id != current_user.id)
      redirect_to categories_path
    end
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def index
    @categories = Category.find_all_by_user_id(current_user.id)
  end

  private
  def category_params
    params.require(:category).permit(:name, :is_income)
  end
end
