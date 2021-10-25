class Customer::UsersController < ApplicationController
  def show
    @user = Customer.find(params[:id])
  end


end
