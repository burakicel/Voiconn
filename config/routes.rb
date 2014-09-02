Rails.application.routes.draw do
  get 'game/dashboard'

  get 'game/buy'

  get 'game/sell'

  get 'game/main'

  get 'game/inventory'

  get 'game/buy/sell'

  get 'game/message'

  get 'game/highscore'

  get 'game/logout'

  get 'login/index'

  resources :users

  get 'welcome/index'
  resources :stocks
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'stocks' => 'stock#index'
  get 'login' => 'login#index'

  match '/login',      to: 'login#new',           via: 'get'

  match '/login/index',      to: 'login#index',        via: 'post'

  match '/game/buy/',      to: 'game#buy',        via: 'post'

  match '/game/sell/',      to: 'game#sell',        via: 'post'


  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
