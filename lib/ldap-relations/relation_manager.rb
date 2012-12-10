module Ldap
  module Relations
    # Store a list of relations and provide methods
    # to output the list as an LDAP filter string.
    class RelationManager
      RELATION_OPERATOR_MAPPINGS = {
        or: '|',
        and: '&',
        not: '!'
      }

      def initialize *args
        self.relations = []
      end

      attr_accessor :relations

      # Public: convert the relations to a LDAP-style filter string.
      #
      # Returns String
      def to_filter
        relation = relations.shift
        case relations.size
        when 0
          "(#{relation.to_filter})"
        when 1
          "(" << RELATION_OPERATOR_MAPPINGS[@relations.first.operator] <<
            "(#{relation.to_filter})(#{relations.first.to_filter}))"
        end
      end
    end
  end
end