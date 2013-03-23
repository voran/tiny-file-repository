Muzika::Application.routes.draw do
  get "/search(.:format)/", :to => redirect("/search(.:format)/(:query)")
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  root :to => redirect("/browse.html/")
end
