class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :shipping_address, dependent: :destroy
  has_many :orders
  has_many :cart_items, dependent: :destroy
  
  validates :first_name, :last_name, presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  
end
