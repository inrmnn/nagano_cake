class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total = 0
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
    
  end
  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
       @cart_item.amount += CartItem.new(cart_item_params).amount
    else
      @cart_item = CartItem.new(cart_item_params)
    end 
    @cart_item.customer_id = current_customer.id
    @cart_item.save!
    redirect_to cart_items_path
   
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end 
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
   redirect_to cart_items_path
  end 
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :cusromer_id, :amount)
  end 
end


