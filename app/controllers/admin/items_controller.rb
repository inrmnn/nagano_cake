class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!

  
  def index
   @items = Item.all
  end

  def new
   @item = Item.new
   @genres = Genre.all
  end
  
   def create
  	@item = Item.new(item_params)
      if @item.save
          flash[:notice] = "新しく商品を追加しました。"
          redirect_to admin_items_path
      else
          render 'new'
      end
   end 
    

  def show
   @item = Item.find(params[:id])
  end

  def edit
   @item =  Item.find(params[:id])
   @genres = Genre.all
  end
  
  def update
   @item =  Item.find(params[:id])
   @item.update(item_params)
   redirect_to admin_item_path
  end
  private
  
  def item_params
     	params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
