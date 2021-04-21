module FactoryBurgers
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

# Factories::Observation.register_link("Account") do |account|
#   {url: Rails.application.routes.url_helpers.ops_account_url(account, host: configatron.static_host)}
# end
#
# Factories::Observation.register_link("Project") do |project|
#   {url: Rails.application.routes.url_helpers.ops_project_url(project, host: configatron.static_host)}
# end
#
# Factories::Observation.register_link("MediaFile") do |media_file|
#   {url: Rails.application.routes.url_helpers.ops_media_file_url(media_file, host: configatron.static_host)}
# end
#
# # TODO: define a block evaluation context that can call all attributes of a
# # factory and determine which invoke sequences, calling them on demand
# Factories::Cheating.advance_sequence(:account_name, Account, :name)
# Factories::Cheating.advance_sequence(:project_name, Project, :name)
# Factories::Cheating.advance_sequence(:user_login, User, :login)
# Factories::Cheating.advance_sequence(:user_email, User, :email)
# Factories::Cheating.advance_sequence(:applicant_email, Applicant, :email)
