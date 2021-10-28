class Customer::OrdersController < ApplicationController

 before_action :authenticate_customer!

 def new
  @order = Order.new
  @shipping_addresses = Address.where(customer_id: current_customer.id)
 end

 def comfirm
  @cart_items = current_customer.cart_items
	 @order = Order.new(
    customer_id: current_customer.id,
    payment_method: params[:order][:payment_method]
    )

  # total_priceに請求額を代入
  # @order.total_payment = billing(@order)

  # addressにresidenceの値がはいっていれば
  if params[:order][:addresses] == "residence"
   @order.postal_code = current_customer.postal_code
   @order.address     = current_customer.address
   @order.name        = current_customer.last_name +
                        current_customer.first_name

  # addressにshipping_addressesの値がはいっていれば
  elsif params[:order][:addresses] == "shipping_addresses"
   ship = Address.find(params[:order][:shipping_address_id])
    @order.postal_code = ship.postcode
    @order.address     = ship.address
    @order.name        = ship.name

    # addressにnew_addressの値がはいっていれば
  elsif params[:order][:addresses] == "new_address"
   @order.postal_code = params[:order][:postal_code]
   @order.address     = params[:order][:address]
   @order.name        = params[:order][:name]
   @ship = "1"

      # バリデーションがあるならエラーメッセージを表示
  unless @order.valid? == true
   @shipping_addresses = Address.where(customer_id: current_customer.id)
   render :new
  end
  end
 end

 def create
  @order = current_customer.orders.new(order_params)
  @order.save
  flash[:notice] = "ご注文が確定しました。"
  redirect_to customer_orders_complete_path

  # もし情報入力でnew_addressの場合ShippingAddressに保存
  if params[:order][:ship] == "1"
   current_customer.shipping_address.create(address_params)
  end

  # カート商品の情報を注文商品に移動
  @cart_items = current_customer.cart_items
  @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.quantity
      order_detail.price = cart_item.item.price
      order_detail.save
  end
  # 注文完了後、カート商品を空にする
  @cart_items.destroy_all
 end

  def complete
  end

  def index
   @orders = current_customer.orders
  end

  def show
   @order = Order.find(params[:id])
   @order_details = @order.order_details
  end

 private

 def order_params
  params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :shipping_cost)
 end

 def address_params
  params.require(:order).permit(:postal_code, :address, :name)
 end


end
