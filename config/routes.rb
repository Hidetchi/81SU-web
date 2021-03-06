ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'players', :action => 'index'
  map.resource :session
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'players', :action => 'create'
  map.signup '/signup', :controller => 'players', :action => 'new'
  map.resend '/resend', :controller => 'players', :action => 'resend_activate'

  map.namespace :api do |api|
    api.connect '/players/search/:name', :controller => 'players', :action => 'search'
    api.connect '/players/ranking/:country_id/:item', :controller => 'players', :action => 'ranking'
    api.connect '/players/ranking34/:country_id/:item', :controller => 'players', :action => 'ranking34'
    api.connect '/players/detail/:name', :controller => 'players', :action => 'detail'
    api.connect '/kifus/search/:player_name/:opponent_name/:begin_date/:end_date', :controller => 'kifus', :action => 'search'
    api.connect '/rate_change_histories/search/:name/:total', :controller => 'rate_change_histories', :action => 'search'
    api.connect '/players/activate/:code1/:code2/:locale', :controller => 'players', :action => 'activate'
    api.connect '/players/reset_pass/:code1/*code2', :controller => 'players', :action => 'reset_pass'
    api.connect '/players/blogparts/:name', :controller => 'players', :action => 'blogparts'
    api.connect '/players/setstyleid/:name/:styleId', :controller => 'players', :action => 'setStyleId'
    api.resources :players, :collection => {:with_login => :get,:authenticate => :get}
    api.resources :kifus, :collection => {:search_tournament => :post}
    api.resources :servers, :collection => {:with_name => :get}
    api.resources :rate_change_histories
  end
  map.resources :players

  map.connect '/locale/:locale', :controller => 'players', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
