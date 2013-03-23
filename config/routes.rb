Muzika::Application.routes.draw do
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  get "/search(.:format)/", :to => redirect("/search(.:format)/(:query)")
  root :to => redirect("/browse.html/")
end
