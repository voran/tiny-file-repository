Muzika::Application.routes.draw do
  match "/browse(.:format)(/*dir)" => "application#browse", :via => :get, :as => :browse
  match "/index(.:format)" => "application#index", :via => :get, :as => :index
  match "/do_index(.:format)" => "application#do_index", :via => :get, :as => :do_index
  root :to => "application#search"
end
