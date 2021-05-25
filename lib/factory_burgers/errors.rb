module FactoryBurgers
  module Errors
    FactoryBurgerError = Class.new(StandardError)
    InvalidAssociationError = Class.new(FactoryBurgerError)
    InvalidRequestError = Class.new(FactoryBurgerError)
  end
end
