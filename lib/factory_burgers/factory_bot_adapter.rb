module FactoryBurgers
  # Wrap FactoryBot knowledge, eventually switch on version
  module FactoryBotAdapter
    module_function

    @loaded = false

    def ensure_loaded
      load_factories if !@loaded
      @loaded = true
    end

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

    def adapter
      # TODO: support non-v6 versions
      FactoryBotAdapter::FactoryBotV6
    end

    def load_factories
      adapter.load_factories
    end

    def factories
      ensure_loaded
      adapter.factories
    end

    def sequences
      ensure_loaded
      adapter.sequences
    end
  end

  module FactoryBotAdapter
    #:nodoc:
    module FactoryBotV6
      module_function

      def load_factories
        FactoryBurgers::FactoryBotAdapter.factory_bot.reload
      end

      def factories
        FactoryBot::Internal.factories
      end

      def sequences
        FactoryBot::Internal.sequences
      end
    end
  end
end
