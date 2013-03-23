Muzika::Application.routes.draw do
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  match "/search.(.:format)/?q=(:query)" => redirect("/search(.:format)/(:query)")
  root :to => redirect("/browse.html/")
end
