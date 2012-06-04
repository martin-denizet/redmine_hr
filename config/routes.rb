ActionController::Routing::Routes.draw do |map|

  map.connect 'hr/contact_list', :controller => 'hr', :action => 'contact_list'
  map.connect 'hr/employees_information', :controller => 'hr', :action => 'employees_information'
  map.resources :hr
  map.resources :hr_job_titles
  map.resources :hr_user_positions
  map.resources :hr_departments
  #map.resources :hr_organizations
  map.resources :hr_employees
  #map.resources :organization
  map.resources :hr_user_details

  map.connect 'hr_departments/hr_organization/:hr_organization', :controller => 'hr_organizations', :action => 'hr_organization'

  map.connect 'hr_organizations/chart/:id', :controller => 'hr_organizations', :action => 'chart'

  map.connect 'hr_organizations/chart', :controller => 'hr_organizations', :action => 'chart'

  map.resources :hr_organizations
  

  map.connect 'hr_user_positions/autocomplete_for_user', :controller => 'hr_user_positions', :action => 'autocomplete_for_user'
  
  map.connect 'hr_user_positions/edit/:id', :controller => 'user_positions', :action => 'edit'

  #map.connect 'hr_departments/edit_membership/:id', :controller => 'hr_departments', :action => 'edit_membership'

  map.connect 'hr_user_positions/membership/:id', :controller => 'hr_user_positions', :action => 'membership'

  #map.connect 'hr_job_titles/:action', :controller => 'hr_job_titles'

  map.connect 'hr_job_titles/create/:type', :controller => 'hr_job_titles', :action => 'create'

 


  #map.connect 'organization/:hr_organization_id/:parent_id/create_department', :controller => 'organization', :action => 'create_department'
  #map.connect 'organization/:hr_organization_id/create_department', :controller => 'organization', :action => 'create_department'
  #
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
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
end
