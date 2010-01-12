ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'players', :action => 'index'
  map.resource :session
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'players', :action => 'create'
  map.signup '/signup', :controller => 'players', :action => 'new'
  map.resources :players

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
