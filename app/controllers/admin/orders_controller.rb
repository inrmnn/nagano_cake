class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def update
     @order = Order.find(params[:id])
     if params[:order][:status] == "b"
       @order.order_details.each do |order_detail|
        order_detail.making_status = "b"
        order_detail.update(making_status: order_detail.making_status)
       end
     end 
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end 
  
   private

  def order_params
    params.require(:order).permit(:status)
  end
end
