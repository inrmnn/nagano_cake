class Public::HomesController < ApplicationController
  def top
     @items = Item.all
     @genres = Genre.all
     if params[:genre_id]
       @genre = Genre.find(params[:genre_id])
       @items = @genre.item.all
     else
       @items = Item.all
     end 
  end

  def about
  end
end
