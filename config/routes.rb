Rails.application.routes.draw do
  
 
 
      # 顧客用
    # URL /customers/sign_in ...
    devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    
    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
     namespace :admin do
        resources :items, only: [:index, :new, :create, :show, :edit, :update]
        
        resources :genres, only: [:index, :create, :edit, :update, :destroy]
       
        resources :customers, only: [:index, :show, :edit, :update]
        
        resources :orders, only: [:show, :update]
        root to: 'orders#index'
        
        resources :order_details, only: [:update
]
      end
     
       scope module: :public do
        resource :customers, only:[:show]
        
        patch '/customer/update' => 'customers#update'
        
        get '/customer/edit' => 'customers#edit'
        
        get '/customers/confirmation' => 'customers#confirmation', as: 'confirmation'
        
        patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'
       
        resources :items, only:[:index,:show]
       
        resources :cart_items, only:[:index, :update ,:create, :destroy]
        delete '/cart_item/destroy_all' => 'cart_items#destroy_all'
       
        resources :orders, only:[:index, :new, :show, :create]
        post '/orders/confirmation' => 'orders#confirmation'
        get '/order/completion' => 'orders#completion'
        
        resources :addresses, only:[:index, :edit, :create, :update, :destroy]
        
        root to: 'homes#top'
        get '/about' => 'homes#about'
      end
    
    
  end
