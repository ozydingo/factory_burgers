module FactoryBurgers
  class FactoryBurgersController < ApplicationController
    layout "main"

    before_action :require_admin

    def require_admin
      true
    end
  end
end
