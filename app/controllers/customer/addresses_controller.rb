class Customer::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = Address.all


  end

  def edit
    @address = Address.find(params[:id])

  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "配送先を登録しました"
      redirect_to customer_addresses_path
    else
      # binding.pry
      @address = Address.new
      @addresses = Address.all
      render 'index'
    end

  end

  def update
       @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to customer_addresses_path
    else
      reder :edit
    end

  end

  def destroy
     Address.find_by(id: params[:id]).destroy
    redirect_to customer_addresses_path, notice: "配送先を1件削除しました"
  end

  private
  def address_params
    params.require(:address).permit(:name, :postcode, :address )
  end

end
