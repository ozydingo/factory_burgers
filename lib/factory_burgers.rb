require Pathname(__dir__).join("factory_burgers/init.rb")

Dir[Pathname(__dir__).join("factory_burgers/**/*.rb")].sort.each do |file|
  require file
end

#:nodoc:
module FactoryBurgers
  class << self
    def root
      @root ||= Pathname(__dir__).expand_path
    end

    def factory_bot_adapter
      @factory_bot_adapter ||= FactoryBotAdapter.new
    end
  end
end
