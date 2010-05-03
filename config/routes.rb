ActionController::Routing::Routes.draw do |map|
  map.load_dnis '/dnis/load', :controller => 'dnis', :action => 'load', :only => [:get, :post]
  map.delete_all_dnis '/dnis/delete_all', :controller => 'dnis', :action => 'delete_all', :only => [:delete]
  map.resources :dnis

  map.connect '/tests/new_image_file', :controller => 'tests', :action => 'new_image_file'
  map.resources :tests
  map.download_test '/tests/:id/download', :controller => 'tests', :action => 'download'
  map.solve_test '/tests/:id/solve', :controller => 'tests', :action => 'solve'

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'

  map.with_options :controller => 'users' do |map_users|
    map_users.delete_all_users '/users/delete_all', :action => 'delete_all', :only => [:delete]
    map_users.register '/register', :action => 'create'
    map_users.signup '/signup', :action => 'new'
    map_users.activate '/activate/:activation_code', :action => 'activate'
  end
  map.resources :users, :member => [:force_activation]

  map.root :controller => 'tests'

  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
