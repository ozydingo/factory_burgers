Rails.application.routes.draw do
  mount FactoryBurgers::App.new, at: "/factory_burgers", as: "factory_burgers"
end
