module Ldap::Relations
  # This class describes an individual filter that can be combined with others
  # to be passed to an LDAP server as part of a search.
  class Relation
    def initialize params={}
      @params = params
    end

    attr_accessor :params

    def to_filter
      "()".insert 1, @params.map {|key, value| "#{key}=#{value}" }.join
    end
  end
end