class Customer::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    @items = Item.where(genre_id: params[:search][:value])
    @genres = Genre.all
    render :index
  end
end
