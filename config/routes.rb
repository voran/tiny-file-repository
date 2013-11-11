Muzika::Application.routes.draw do
  match "/search(.:format)/" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  match "/index(.:format)" => "application#index"
  root :to => redirect("/search.html/")
end
