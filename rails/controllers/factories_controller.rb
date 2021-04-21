module FactoryBurgers
  class FactoryBurgersController < ActionController::Base
    layout "main"

    before_action :require_auth

    def index
      factories = FactoryBot.factories.sort_by(&:name)
      factory_data = factories.map { |factory| factory_data(factory) }
      @props = {
        csrfToken: form_authenticity_token,
        factories: factory_data,
        submitPath: build_testing_factories_path,
      }
    end

    def build
      factory = params.require(:factory)
      traits = params[:traits]&.keys
      attributes_params = params.permit(attributes: [:name, :value])[:attributes]
      attributes = attributes_params.select { |attr| attr[:name].present? }.map { |attr| [attr[:name], attr[:value]] }.to_h
      resource = insistently do
        FactoryBot.create(factory, *traits, attributes)
      end
      owner = get_resource_owner(params)
      update_owner_resource(owner, params[:owner_association], resource) if owner

      render json: {ok: true, data: built_object_data(resource)}
    rescue ActiveRecord::RecordInvalid => err
      log_error(err)
      render status: :unprocessable_entity, json: {ok: false, error: err.message}
    rescue StandardError => err
      log_error(err)
      render status: :internal_server_error, json: {ok: false, error: err.message}
    end

    private

    def require_auth
      true
    end

    # Brute force through sequences (e.g. account name) to overcome uniqueness validations
    def insistently(tries = 30)
      tries.times do |attempt|
        return yield
      rescue ActiveRecord::RecordInvalid
        raise if attempt >= tries - 1
      end
    end

    def factory_data(factory)
      traits = factory.definition.defined_traits
      {
        name: factory.name,
        class_name: factory.build_class.base_class.name,
        traits: traits.map { |trait| trait_data(trait) },
        attributes: factory.build_class.columns.reject { |col| col.name == "id" }.map { |col| attribute_data(col) },
        # TODO: transient attributes (f.definition.attributes ...?), associations
      }
    end

    def trait_data(trait)
      {
        name: trait.name,
      }
    end

    def attribute_data(attribute)
      {
        name: attribute.name,
      }
    end

    def built_object_data(object)
      association_factories = FactoryBurgers::Introspection.association_factories(object.class)
      association_factories.sort_by! { |item| item[:association].name }
      return {
        type: object.class.name,
        attributes: object.attributes,
        association_factories: association_factories.map { |item| association_factory_data(item) },
        link: FactoryBurgers::Observation.app_link(object),
      }
    end

    def association_factory_data(assoc_factory)
      {
        association_name: assoc_factory[:association].name.to_s,
        factory_name: assoc_factory[:factory].name.to_s,
      }
    end

    def get_resource_owner(params)
      return nil if params[:owner_type].blank? || params[:owner_id].blank? || params[:owner_association].blank?

      valid_owner_types = ActiveRecord::Base.descendants.map(&:name)
      raise "Danger, will Robinson! #{params[:owner_type]} is an impostor!" if !valid_owner_types.include?(params[:owner_type])

      klass = params[:owner_type].constantize
      raise "Danger, will Robinson! #{params[:owner_association]} is an impostor!" if !klass.reflections.include?(params[:owner_association])

      return params[:owner_type].constantize.find(params[:owner_id])
    end

    def update_owner_resource(owner, name, resource)
      reflection = owner.class.reflections[name] or raise "Could not find reflection named #{name}"
      if reflection.is_a?(ActiveRecord::Reflection::HasManyReflection)
        owner.update!(name => owner.public_send(name) + [resource])
        resource.reload
      else
        owner.update!(name => resource)
      end
    end

    def log_error(err)
      Rails.logger.error("#{err.class}: #{err.message}\n" + err.backtrace&.join("\n").to_s)
    end
  end
end
