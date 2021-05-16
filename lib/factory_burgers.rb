require Pathname(__dir__).join("factory_burgers/init.rb")

Dir[Pathname(__dir__).join("factory_burgers/*.rb")].each do |file|
  require file
end

module FactoryBurgers
  class << self
    def root
      @root ||= Pathname(__dir__).expand_path
    end
  end
end
