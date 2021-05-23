module FactoryBurgers
  # Wrap FactoryBot knowledge, eventually switch on version
  module FactoryBotAdapter
    module_function

    def factory_bot
      FactoryBot
    end

    def version
      factory_boy::VERSION
    end

    def numeric_version
      verion.split(".").map(&:to_i)
    end

    def major_version
      numeric_versionnn.first
    end

    # TODO: support non-v6 versions
    def load_factories
      FactoryBotAdapter::FactoryBotV6.load_factories
    end

    def factories
      FactoryBot::Internal.factories
    end

    def sequences
      FactoryBot::Internal.sequences
    end
  end

  module FactoryBotAdapter
    #:nodoc:
    module FactoryBotV6
      module_function

      def load_factories
        FactoryBurgers::FactoryBotAdapter.factory_bot.reload
      end
    end
  end
end
