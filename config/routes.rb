LabMaster::Application.routes.draw do

  root :to => 'home#index'

  # Group
  resources :group, except: [:show]

  # Twitter
  resources :twitter, only: [:index, :show]

  # Facebook
  resources :facebook, only: [:index, :show]
  match 'facebook/group/:group_id' => 'facebook#group'

  # Mail
  resources :mail, only: [:index]

  # File
  resources :attachment, only: [:index, :show]
  match 'attachment/download/:id' => 'attachment#download'

  # Blog 
  resources :blog, except: [:show]

  # Ajax
  match 'ajax/search_website' => 'ajax#search_website'

  # Ominuauthの設定
  match 'auth/twitter/callback' => 'sessions#callback'
  match 'auth/facebook/callback' => 'sessions#fb_callback'
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/logout' => 'sessions#fb_destroy', :as => :logout

  #match 'home/pdf' => 'home#pdf'
  
  #get "group/index"
  #get "group/new"
  #get "group/create"
  #get "group/edit"
  #get "group/update"
  #get "group/destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
