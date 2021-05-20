module FactoryBurgers
  # TODO: replace behaviors with presenters
  module Observation
    @links = {}

    module_function

    def register_link(klass, &blk)
      @links[klass.to_s] = blk
    end

    def purge!
      @links = {}
    end

    def app_link(object, *args)
      proc = @links[object.class.to_s] or return nil

      data = proc.call(object, *args)
      data[:label] ||= default_label(object)
      return data
    end

    def default_label(object)
      label = object.class.to_s
      label += " \"#{object.name}\"" if object.respond_to?(:name)
      label += " (#{object.id})"
      return label
    end
  end
end
