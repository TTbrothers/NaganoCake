class Customer::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to customer_cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @item = Item.find(params[:cart_item][:item_id])
      @genres = Genre.all
      render 'customer/items/show'
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to customer_cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to customer_cart_items_path
  end

  def destroy_all
    @items = current_customer.cart_items.destroy_all
    redirect_to customer_cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
  end
end
