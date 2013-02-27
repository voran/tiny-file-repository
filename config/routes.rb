Muzika::Application.routes.draw do
  match "/search/:query(/:page)(/:results_per_page)" => "application#search", :format => false
  match "/browse(/*dir)" => "application#browse", :format => false
end
