class Public::HomesController < ApplicationController
  
  def top
    @items = Item.last(4)
    @genres = Genre.all
  end
  
  def about
  end
  
end
