Muzika::Application.routes.draw do
  match "/api/search/:query(/:page)(/:results_per_page)" => "application#search" , :format => html
  match "/api/browse(/*dir)" => "application#browse" , :format => html
end
