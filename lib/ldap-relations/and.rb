module Ldap
  module Relations
    class And
      def initialize left, right
        @left = left
        @right = right
      end

      attr_accessor :left, :right

      def to_filter
        "(&#{left.to_filter}#{right.to_filter})"
      end
    end
  end
end