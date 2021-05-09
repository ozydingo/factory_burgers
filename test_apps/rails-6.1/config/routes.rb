Rails.application.routes.draw do
  mount FactoryBurgers::App, at: "/factory_burgers", as: "factory_burgers"
end
