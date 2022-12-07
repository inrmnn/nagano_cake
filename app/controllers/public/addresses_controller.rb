class Public::AddressesController < ApplicationController
    def index
        @address_new = Address.new
        @address = Address.all
    end
    
    def create
        @address_new = Address.new(address_params)
        @address_new.customer_id = current_customer.id
        if @address_new.save
            redirect_to addresses_path
        else
            @address = current_customer.address
            render :index
        end 
    end 
    
    def edit 
        @address = Address.find(params[:id])
    end 
    
    def destroy
         @address = Address.find(params[:id])
         @address.destroy
         redirect_to addresses_path
    end 
     
    def update
         @address = Address.find(params[:id])
         @address.update(address_params)
         redirect_to addresses_path
    end 
    
    private
    def address_params
        params.require(:address).permit(:name, :postal_code, :address)
    end 
end 