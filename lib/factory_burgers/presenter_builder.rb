module FactoryBurgers
  class PresenterBuilder < BasicObject
    def initialize(klass)
      @presenter = ::Class.new(::FactoryBurgers::Presenters::Base)
      @klass = klass
    end

    def build(&blk)
      instance_eval(&blk)
      return @presenter
    end

    def presents(name)
      @presetner.presents(name)
    end

    def type(&blk)
      @presenter.define_method(:type) do
        blk.call(object)
      end
    end

    def type(&blk)
      @presenter.define_method(:type) do
        blk.call(object)
      end
    end

    def attributes(&blk)
      @presenter.define_method(:attributes) do
        blk.call(object)
      end
    end

    def link_path(&blk)
      @presenter.define_method(:link_path) do
        blk.call(object)
      end
    end
  end
end
