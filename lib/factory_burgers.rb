require Pathname(__dir__).join("factory_burgers/init.rb")

Dir[Pathname(__dir__).join("factory_burgers/**/*.rb")].sort.each do |file|
  require file
end

# :nodoc:
module FactoryBurgers
  class << self
    delegate :run_initializers, to: :initializer

    def root
      @root ||= Pathname(__dir__).expand_path
    end

    def factory_bot_adapter
      @factory_bot_adapter ||= FactoryBotAdapter.new
    end

    def initializer
      FactoryBurgers::Initializer
    end

    def loaded(&blk)
      initializer.add_initializer(blk)
    end
  end
end
