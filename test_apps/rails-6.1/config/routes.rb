Rails.application.routes.draw do
  mount FactoryBurgers::App, at: "/factory_burgers", as: "factory_burgers"

  resources :posts, only: [:show]
  resources :users, only: [:show]
end
