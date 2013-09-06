class MoneyMove < ActiveRecord::Base
  belongs_to :category
  validates :price, presence: true, numericality: true
end
