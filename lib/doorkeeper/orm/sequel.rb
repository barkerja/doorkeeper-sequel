module Doorkeeper
  module Orm
    # Sequel ORM for Doorkeeper
    module Sequel
      def self.initialize_models!
        require 'doorkeeper/orm/sequel/sequel_compat'
        require 'doorkeeper/orm/sequel/access_grant'
        require 'doorkeeper/orm/sequel/access_token'
        require 'doorkeeper/orm/sequel/application'
      end

      def self.initialize_application_owner!
        require 'doorkeeper/models/concerns/ownership'

        Doorkeeper::Application.send :include, Doorkeeper::Models::Ownership
      end

      def self.check_requirements!(_config);
#         if Doorkeeper::Application.db.test_connection &&
#            Doorkeeper::Application.table_exists?
#           unless Doorkeeper::Application.new.attributes.include?('scopes')
#             migration_path = '../../../generators/doorkeeper/templates/add_scopes_to_oauth_applications.rb'
#             puts <<-MSG.squish
# [doorkeeper] Missing column: `oauth_applications.scopes`.
# Create the following migration and run `rake db:migrate`.
#             MSG
#             puts File.read(File.expand_path(migration_path, __FILE__))

#         # If !Doorkeeper::Application.new.attributes.include?('scopes')
#         # Migrations need run
#       rescue
#         false
      end
    end
  end
end
