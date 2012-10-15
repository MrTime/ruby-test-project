RubyTestProject::Application.routes.draw do
  #get "home/index"

  root :to => 'home#index' #home page

  devise_for :users,:controllers => { :registrations => "registrations" }

  resources :users, :sign_up do
    resources :photos
  end

  #match '/users/new_photo' => 'users#new_photo'
  #match '/users/add_photo' => 'users#add_photo' ,   :via => :post
  #match '/users/new_photo' => 'photos#new'
  #match '/users/add_photo' => 'photos#add_photo' , :via => :post

  #match '/books/:id/new_photo' => 'books#new_photo'
  #match '/books/add_photo'     => 'books#add_photo', :via => :post

  resources :books do
    resources :photos
  end


  #match "books/:author" => "books#find_by_author"
  #match 'books' => 'books#index', :via => :get

  #match 'authors/list_authors'
  #match 'authors/books_author/:author' => 'authors#books_author'
  resources :authors do
    resources :books, only: :index
  end

  #match 'search' => 'search#index'
  #match 'search_books' => 'search#search_books'
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
