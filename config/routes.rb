Muzika::Application.routes.draw do
  match "/search.html/?query=(:query)" => "appliction#search_redirect"
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  root :to => redirect("/browse.html/")
end
