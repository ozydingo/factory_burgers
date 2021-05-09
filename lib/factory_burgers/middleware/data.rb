require "json"

module FactoryBurgers
  module Middleware
    class Data
      def call(env)
        data = {ok: true}
        return [200, {"Content-Type" => "application/json"}, [JSON.dump(data)]]
      end
    end
  end
end
