RubyRailsSample::Application.routes.draw do
  get "notifications/index"
  get "notifications/create"
  root 'welcome#new'    
  resource :welcome
  resource :register
  resource :user
  resource :login
  resource :activate
  resource :gamemain
  match '/welcome',      to: 'welcome#new',           via: 'get'
  match '/welcome',      to: 'welcome#deliver',        via: 'post'
  match '/register',      to: 'register#new',           via: 'get'
  match '/register',      to: 'register#createUser',        via: 'post'
  match '/activate',      to: 'activate#create',        via: 'post'
  match '/activate',      to: 'activate#deliver',        via: 'get'
  match '/gamemain',      to: 'gamemain#create',        via: 'post'
  match '/gamemain',      to: 'gamemain#deliver',        via: 'get'
  match '/login',      to: 'login#new',           via: 'get'
  match '/login',      to: 'login#loginUser',        via: 'post'
  match '/login',      to: 'login#deliver',        via: 'post'
  match '/user',      to: 'user#new',           via: 'get'
  match '/user',      to: 'user#deliver',        via: 'post'
  match '/activate',      to: 'activate#verify',           via: 'get'
  match '/activate',      to: 'activate#verify',        via: 'post'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
