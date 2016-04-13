module Doorkeeper
  module Models
    module SequelCompat
      extend ActiveSupport::Concern

      included do
        plugin :timestamps, update_on_create: true
        plugin :association_proxies
        plugin :validation_helpers
      end

      def to_param
        id
      end

      module ClassMethods
        def create!(*args)
          create(*args)
        end

        def find(id)
          if id.is_a?(Fixnum) || id.is_a?(String)
            self[id.to_i]
          else
            super
          end
        end

        def table_exists?
          db.tables.include?(table_name.to_sym)
        end
      end
    end
  end
end
