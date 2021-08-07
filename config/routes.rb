Rails.application.routes.draw do
  # 会員側ユーザ機能
  devise_for :customers, :controllers => {
    :sessions => 'customers/sessions',
    :registrations => 'customers/registrations',
  }

  # 管理者側ユーザ機能
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions',
    :registrations => 'admins/registrations',
  }

  devise_for :users

  # 管理者側ルーティング設定
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
    get '/' => 'homes#top', as: 'top'
  end

  # 会員側ルーティング設定
  scope module: :public do
    # homesコントローラのルーティング
    root to: 'homes#top'
    get '/top' => 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    # itemsコントローラのルーティング
    resources :items, only: [:index, :show]
    # customersコントローラのルーティング
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    # cart_itemsコントローラのルーティング
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    # ordersコントローラのルーティング
    resources :orders, only: [:new, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
        post 'definition'
      end
    end
    # addressesコントローラのルーティング
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
