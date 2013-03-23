Muzika::Application.routes.draw do
  match "/search.html/?query=(:query)" => redirect  { |params| "/search.html/#{params[:query]}" }
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  root :to => redirect("/browse.html/")
end
