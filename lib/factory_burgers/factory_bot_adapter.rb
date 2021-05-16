module FactoryBurgers
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
      FactoryBot::V6.load_factories
    end

    def factories
      FactoryBot::Internal.factories
    end

    def sequences
      FactoryBot::Internal.sequences
    end
  end

  module FactoryBotAdapter
    module FactoryBot::V6
      module_function

      def load_factories
        FactoryBurgers::FactoryBotAdapter.factory_bot.reload
      end
    end
  end
end
