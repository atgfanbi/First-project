class MoneyMovesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @move = @category.money_moves.create(params[:money_move].permit(:price, :description, :date))
    redirect_to category_path(@category)
  end

  def destroy
    @category = Category.find(params[:category_id])
    @move = @category.money_moves.find(params[:id])
    @move.destroy
    redirect_to category_path(@category)
  end

  def show
    @category = Category.find(params[:category_id])
    @move = @category.money_moves.find(params[:id])
    if(@category.user_id != current_user.id)
      redirect_to categories_path
    end
  end

  def edit
    @move = MoneyMove.find(params[:id])
    @category = Category.find(@move.category_id)
    if(@category.user_id != current_user.id)
      redirect_to categories_path
    end
  end

  def update
    @move = MoneyMove.find(params[:id])
    if @move.update(params[:money_move].permit(:price, :description, :date))
      redirect_to category_path(@move.category_id)
    else
      render 'edit'
    end
  end
end
