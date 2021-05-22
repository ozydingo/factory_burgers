# Module for adding, finding, and using application data presenters. Presenters
# are used to define what attributes to show in the front end, what to call the
# built objects, and managing links to the objects in the application if they
# exist.

module FactoryBurgers
  module Presenters
    @presenters = {}

    module_function

    def present(klass, with: nil, &blk)
      raise ArgumentError, "Provide `with` or block, but not both" if with && blk

      presenter = with || build_presenter(klass, &blk)
      @presenters[klass.to_s] = presenter
    end

    def purge!
      @links = {}
      @presenters = {}
    end

    def presenter_for(object)
      presenter_class_for(object).new(object)
    end

    def presenter_class_for(object)
      matching_class = object.class.ancestors.map(&:name).find do |class_name|
        @presenters.key?(class_name)
      end

      return matching_class ? @presenters[matching_class] : FactoryBurgers::Presenters::Base
    end

    # TODO use this from FactoryOutput
    def data_for(object)
      presenter = presenter_for(object) or return nil
      {
        type: presenter.type,
        attributes: presenter.attributes,
        link: presenter.link_path,
      }
    end

    # block provided to `present`; build a presenter class
    def build_presenter(klass, &blk)
      PresenterBuilder.new(klass).build(&blk)
    end
  end
end
