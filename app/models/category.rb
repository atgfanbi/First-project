class Category < ActiveRecord::Base
  has_many :money_moves, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
end
