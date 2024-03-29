module FactoryBurgers
  # Wrap FactoryBot knowledge, eventually switch on version
  class FactoryBotAdapter
    def initialize
      @loaded = false
    end

    def ensure_loaded
      if !@loaded
        load_factories
        FactoryBurgers.run_initializers
      end
      @loaded = true
    end

    def factory_bot
      FactoryBot
    end

    def version
      factory_bot::VERSION
    end

    def numeric_version
      verion.split(".").map(&:to_i)
    end

    def major_version
      numeric_version.first
    end

    def adapter
      # TODO: support non-v6 versions
      @adapter ||= FactoryBotAdapters::FactoryBotV6.new
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

  module FactoryBotAdapters
    # :nodoc:
    class FactoryBotV6
      def load_factories
        FactoryBot.reload
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
