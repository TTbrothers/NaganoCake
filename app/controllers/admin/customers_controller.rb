class Admin::CustomersController < ApplicationController

  def index
    @customer = Customer.all
    @customers = Customer.page(params[:page]).per(1)
  end

  def show
    @customer = Customer.find(params[:id])

  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      reder :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number )
  end
end
