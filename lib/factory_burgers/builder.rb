module FactoryBurgers
  # Build resources from specified factories, traits, and attributes
  class Builder
    attr_reader :owner

    # `owner` is an optional resource that we can attach new resources to
    # E.g. a `User` for whom we wish to build a `Post`.
    def initialize(owner = nil)
      @owner = owner
    end

    # TODO: clean up method signature
    def build(factory, traits, attributes, as: nil) # rubocop:disable Naming/MethodParameterName; as is a good name here
      resource = insistently do
        FactoryBot.create(factory, *traits, attributes)
      end
      update_assocation_to_owner(as, resource) if owner && as

      return resource
    end

    private

    def update_assocation_to_owner(association_name, resource)
      reflection = get_owner_association(association_name)
      case reflection
      when ActiveRecord::Reflection::BelongsToReflection, ActiveRecord::Reflection::HasOneReflection
        # This will update the foreign key on `resource` for has_one.
        owner.update!(association_name => resource)
      when ActiveRecord::Reflection::HasManyReflection
        # This will update the foreign key on `resource`.
        owner.public_send(association_name) << resource
      else
        invalid_association(reflection)
      end
    end

    def get_owner_association(name)
      owner.class.reflections[name.to_s] or raise "Could not find association named #{name}"
    end

    # Brute force through sequences (e.g. account name) to overcome uniqueness validations
    def insistently(tries = 30)
      tries.times do |attempt|
        return yield
      rescue ActiveRecord::RecordInvalid
        raise if attempt >= tries - 1
      end
    end

    def invalid_association(reflection)
      msg = "#{reflection.class} association #{reflection.name} on #{reflection.active_record.name} is not supported."
      raise FactoryBurgers::Errors::InvalidAssociationError, msg
    end
  end
end
