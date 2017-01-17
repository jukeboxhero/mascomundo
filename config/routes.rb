Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.add_routes do
    namespace :account do
      resources :orders
    end

    get 'products/:id/quickview', to: 'products#quickview', as: :quickview
  end

  Spree::Core::Engine.routes.prepend do
    # Your new routes
  end

  resources :products

  resource :about, only: [:show], controller: :about, as: :about
  resource :contact, only: [:show], controller: :contact, as: :contact
  resource :advanced_search, only: [:show], controller: :advanced_search, as: :advanced_search

  root 'home#index'
end
