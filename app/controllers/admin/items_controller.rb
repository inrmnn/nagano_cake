class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!

  
  def index
  end

  def new
   @admins_item = Item.new

  end

  def show
  end

  def edit
  end


end
