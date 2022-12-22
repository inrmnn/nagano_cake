class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order =  @order_detail.order
    if @order_detail.making_status == 'c'
       @order.update(status: 'c')
    end 
   
    change_status(@order)
   
    redirect_to admin_order_path(@order_detail.order.id)
  end

  
  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
  def change_status(order)
    order.order_details.each do |order_detail|
      if order_detail.making_status != 'd'
        return
      end
    end 
    order.update(status: 'd')
  end 
end
