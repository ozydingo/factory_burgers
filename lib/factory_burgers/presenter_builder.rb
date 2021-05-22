# The PresenterBuilder is resposible for building anonymous subclasses of
# FactoryBurgers::Presenters::Base when FactoryBurgers::Presenters.present is
# called with a block. The block is evaluated in the context of a
# FactoryBurgers::PresenterBuilder instance, which understands the DSL.

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
