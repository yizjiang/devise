module Devise
  module Models
    # Registerable is responsible for everything related to registering a new
    # resource (ie user sign up).
    module Registerable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        []
      end

      module ClassMethods
        # A convenience method that receives both parameters and session to
        # initialize a user. This can be used by OAuth, for example, to send
        # in the user token and be stored on initialization.
        #
        # By default discards all information sent by the session by calling
        # new with params.
        def agent_params(params)
          agent_identifier = params.delete(:agent_identifier)
          agent_license_id = params.delete(:agent_license_id)
          return agent_identifier,agent_license_id
        end
        def new_with_session(params, session)
          p 'xxx here'

          agent_identifier,agent_license_id = agent_params(params)

          user = new(params)
          if agent_identifier && agent_license_id
            user.create_agent_extension(agent_identifier, agent_license_id)
          end
          p "xxx #{user}"
          user
        end
      end
    end
  end
end
