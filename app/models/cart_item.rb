class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :quantity, presence: true
end
