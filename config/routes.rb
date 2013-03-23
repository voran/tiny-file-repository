Muzika::Application.routes.draw do
  match "/search(.:format)/(:query)(/:page)(/:results_per_page)" => "application#search"
  match "(/*dir)" => "application#index"
end
