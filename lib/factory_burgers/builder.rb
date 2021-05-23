module FactoryBurgers
  # Build resources from specified factories, traits, and attributes
  class Builder
    # TODO: clean up method signature
    def build(factory, traits, attributes, owner)
      resource = insistently do
        FactoryBot.create(factory, *traits, attributes)
      end
      update_owner_resource(owner, params[:owner_association], resource) if owner

      return resource
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

    # Brute force through sequences (e.g. account name) to overcome uniqueness validations
    def insistently(tries = 30)
      tries.times do |attempt|
        return yield
      rescue ActiveRecord::RecordInvalid
        raise if attempt >= tries - 1
      end
    end
  end
end
