class ReportController < ApplicationController
  def index
    @selected_category = "Please select"
    @date_to = Time.current
    @date_from = Time.current
    @categories = Category.find(:all, :conditions => ["user_id = ?", current_user.id])
    @move = MoneyMove.find_all_by_category_id(@categories, :order => "date")
  end
  def create
    @date_to = Date.new(params[:date_to][:year].to_i, params[:date_to][:month].to_i, params[:date_to][:day].to_i)
    @date_from = Date.new(params[:date_from][:year].to_i, params[:date_from][:month].to_i, params[:date_from][:day].to_i)
    @date_q_to = params[:date_to][:year]+"."+params[:date_to][:month]+"."+params[:date_to][:day]
    @date_q_from = params[:date_from][:year]+"."+params[:date_from][:month]+"."+params[:date_from][:day]
    if(params[:category][:id]=="")
      @categories = Category.find(:all, :conditions => ["user_id = ?", current_user.id])
    else
      @selected_category = params[:category][:id]
      @categories = Category.find(:all, :conditions => ["user_id = ? AND id = ?", current_user.id, params[:category][:id]])
    end
    @move = MoneyMove.find_all_by_category_id(@categories, :conditions => ["date >= ? AND date <=?", @date_q_from, @date_q_to], :order => "date")
    render "index"
  end
end
