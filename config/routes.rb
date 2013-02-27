Muzika::Application.routes.draw do
  match "/api/search/:query(/:page)(/:results_per_page)" => "application#search", :format => false
  match "/api/browse(/*dir)" => "application#browse", :format => false
end
