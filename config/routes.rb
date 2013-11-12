Muzika::Application.routes.draw do
  match "/search(.:format)/" => "application#search", via: [:get, :post]
  match "/browse(.:format)/(/*dir)" => "application#browse", via: :get
  match "/index(.:format)" => "application#index", via: :get
  root :to => redirect("/search.html/")
end
