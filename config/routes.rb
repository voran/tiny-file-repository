Muzika::Application.routes.draw do
  match "/api/search(.:format)/:query(/:page)(/:results_per_page)" => "application#search"
  match "/api/browse(.:format)(/*dir)" => "application#browse"
end
