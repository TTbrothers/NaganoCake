class Customer::UsersController < ApplicationController
  def show
    @user = Customer.find(params[:id])

  end
  
  def edit
    @user = Customer.find(params[:id])
  end
  
  def update
    @user = current_customer
    if @user.update(customer_params)
      redirect_to customer_user_path(@user)
    else 
      reder :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number )
  end  
  
end
