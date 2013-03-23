Muzika::Application.routes.draw do
  match "/submit.html/?query=(:query)" => redirect_to  { |params| "/search.html/#{params[:query]}" }
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "/browse(.:format)/(/*dir)" => "application#browse"
  root :to => redirect("/browse.html/")
end
