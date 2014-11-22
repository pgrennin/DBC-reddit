Rails.application.routes.draw do

  resources :users
  resources :votes
  resources :sessions
  resources :subscriptions
  resources :subreddits do
    resources :posts do
      resources :comments, only: [:destroy, :new, :create, :update]
    end
  end

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'
  # get '/logout' => 'sesssions#destroy'
  delete '/logout' => 'sessions#destroy', :via => :delete

  post '/search' => 'posts#search'


  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # match 'exit' => 'sessions#destroy', :as => :logout

  # Example of named route that can be invoked with purchase_url(id: product.id)
    # get 'subreddits/:subreddit_id' => 'subreddit#show', as: :subreddit.name

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
