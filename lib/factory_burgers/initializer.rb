module FactoryBurgers
  # Singleton handling lazy initialization hooks
  # This feature is useful for running code after all application environment
  # code has been loaded, such as to auto-advance model sequences
  module Initializer
    module_function

    @initializers = []
    @initialized = false

    def run_initializers
      return if @initialized

      @initializers.each(&:call)
      @initialized = true
    end

    def add_initializer(proc)
      @initializers << proc
    end
  end
end
