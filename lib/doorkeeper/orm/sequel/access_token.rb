module Doorkeeper
  class AccessToken < Sequel::Model(:oauth_access_tokens)
    include Doorkeeper::Models::SequelCompat
    include Doorkeeper::OAuth::Helpers
    include Doorkeeper::Models::Expirable
    include Doorkeeper::Models::Revocable
    include Doorkeeper::Models::Accessible
    include Doorkeeper::Models::Scopes

    def self.delete_all_for(application_id, resource_owner)
      where(application_id: application_id,
            resource_owner_id: resource_owner.id)
        .delete
    end
    private_class_method :delete_all_for

    def self.last_authorized_token_for(application, resource_owner_id)
      where(application_id: application.id,
            resource_owner_id: resource_owner_id,
            revoked_at: nil)
        .reverse_order(:created_at)
        .limit(1)
        .first
    end
    private_class_method :last_authorized_token_for

    many_to_one :application, class: 'Doorkeeper::Application'

    def validate
      generate_token if new?
      generate_refresh_token if new? && use_refresh_token?

      super

      validates_presence [:application_id, :token]
      validates_unique :token
      validates_unique :refresh_token if use_refresh_token?
    end

    attr_accessor :use_refresh_token

    def self.authenticate(token)
      where(token: token).first
    end

    def self.by_refresh_token(refresh_token)
      where(refresh_token: refresh_token).first
    end

    def self.revoke_all_for(application_id, resource_owner)
      delete_all_for(application_id, resource_owner)
    end

    def self.matching_token_for(application, resource_owner_or_id, scopes)
      resource_owner_id =
        if resource_owner_or_id.is_a?(Fixnum)
          resource_owner_or_id
        else
          resource_owner_or_id.id
        end

      token = last_authorized_token_for(application, resource_owner_id)
      token if token && ScopeChecker.matches?(token.scopes, scopes)
    end

    def token_type
      'bearer'
    end

    def use_refresh_token?
      use_refresh_token
    end

    def as_json(_options = {})
      {
        resource_owner_id:  resource_owner_id,
        scopes:             scopes,
        expires_in_seconds: expires_in_seconds,
        application:        { uid: application.uid }
      }
    end

    private

    def generate_refresh_token
      self.refresh_token = UniqueToken.generate
    end

    def generate_token
      self.token = UniqueToken.generate
    end
  end
end
