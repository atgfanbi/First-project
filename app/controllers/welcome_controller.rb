class WelcomeController < ApplicationController
  def index
    @users_count = User.count
    if(@users_count == 0)
      @in_per_user = 0
      @ex_per_user = 0
      @mid_in = 0
      @mid_ex = 0
    else
      @in_users = Category.find_all_by_is_income(true)
      @ex_uses = Category.find_all_by_is_income(false)
      @in_per_user = (@in_users.count / @users_count.to_f).round 2
      @ex_per_user = (@ex_uses.count / @users_count.to_f).round 2
      if(MoneyMove.find_all_by_category_id(@in_users).count == 0)
        @mid_in = 0
      else
        @mid_in = (MoneyMove.find_all_by_category_id(@in_users).sum(&:price) / MoneyMove.find_all_by_category_id(@in_users).count).round 2
      end
      if(MoneyMove.find_all_by_category_id(@ex_uses).count == 0)
        @mid_ex = 0
      else
        @mid_ex = (MoneyMove.find_all_by_category_id(@ex_uses).sum(&:price) / MoneyMove.find_all_by_category_id(@ex_uses).count).round 2
      end
    end
  end
  def new
  end
end
