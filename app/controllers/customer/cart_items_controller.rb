class Customer::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to customer_cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def update
  end

  def destroy
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
  end
end
