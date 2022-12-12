class Public::OrdersController < ApplicationController
  
  def index
    @orders = current_customer.orders
  end
  
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end
  
  def confirmation
    @cart_item = current_customer.cart_items
    @order = Order.new(order_params)
    @order.postage = 800
    @order.payment = params[:order][:payment]
    
    if params[:order][:my_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      
    elsif params[:order][:my_address] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      
    elsif params[:order][:my_address] == "3"
       @order.postal_code = params[:order][:postal_code]
       @order.address = params[:order][:address]
       @order.name = params[:order][:name]
    end
        
  end 
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save!
    
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.amount = cart_item.amount
      @order_detail.purchase_price = cart_item.item.price * cart_item.amount 
      @order_detail.making_status = 0
      @order_detail.save
      end
      
      @cart_items.destroy_all
      redirect_to order_completion_path
  end 
  
 

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
  end
  
  def completion
  end 
  
  private
  
  def order_params
      params.require(:order).permit(:payment, :postal_code, :address, :name, :billing_amount, :postage, :status, :customer_id)
  end
end
