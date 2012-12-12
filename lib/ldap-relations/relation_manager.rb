module Ldap
  module Relations
    # Store a list of relations and provide methods
    # to output the list as an LDAP filter string.
    class RelationManager
      def initialize *args
        self.relations = RelationGrouping.new
      end

      attr_accessor :relations

      # Public: convert the relations to an LDAP-style filter string.
      #
      # Returns String
      def to_filter
        relations.to_filter
      end
    end

    class RelationGrouping < Array
      def to_filter
        map(&:to_filter).join
      end
    end
  end
end