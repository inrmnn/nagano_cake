class Public::ItemsController < ApplicationController
  def index
     @items = Item.all
     @genres = Genre.all
     if params[:genre_id]
       @genre = Genre.find(params[:genre_id])
       @items = @genre.item.all
     else
       @items = Item.all
     end 
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
    @items = Item.all
    @genres = Genre.all
    if params[:genre_id]
       @genre = Genre.find(params[:genre_id])
       @items = @genre.item.all
    else
       @items = Item.all
    end 
  end
 
  private
  def item_params
  	  params.require(:item).permit(:name, :introduction, :image, :is_active, :price,:genre_id)
  end
end
