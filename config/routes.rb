Rails.application.routes.draw do
  
 
 
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
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
      resources :items, only: [:index, :new, :create, :show, :edit]
      end
      
     namespace :admin do
      resources :genres, only: [:index, :create, :edit, :update]
     end
     
      namespace :admin do
       resources :customers, only: [:index, :show, :edit, :update]
      end
     
      namespace :public do
       resource :customers, only:[:show, :edit, :update]
       
       get '/customers/confirmation' => 'customers#confirmation', as: 'confirmation'
       
       patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'
      end
    namespace :public do
      root to: 'homes#top'
      get '/about' => 'homes#about'
    end
    
    
  end
