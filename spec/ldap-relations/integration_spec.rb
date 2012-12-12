require 'spec_helper'
require 'ldap-relations'

# Example ActiveRecord style usage for LRel
#
# eg. Directory.where(sAMAccountName: 'test').all
class Directory
  def self.where params
    new.where(params)
  end

  def initialize params={}
    self.manager = LRel::RelationManager.new
  end

  attr_accessor :manager

  def where params
    query = params.shift
    manager.relations << LRel::Relation.new(query.first.to_s => query.last)
    if !params.empty?
      self.and(params)
    end
    self
  end

  def and params
    query = params.shift
    relation = LRel::Relation.new(query.first.to_s => query.last)
    if params.any?
      LRel::And.new(relation, self.and(params))
    else
      relation
    end
  end

  def or params
    manager.relations = LRel::Or.new(manager.relations, LRel::Relation.new(params))
    self
  end

  def default_relation
    LRel::Relation.new(objectCategory: 'person')
  end

  def to_filter
    manager.relations = LRel::And.new(default_relation, manager.relations)
    manager.to_filter
  end

  alias :all :to_filter
end

describe "integration" do
  let(:directory) { Directory.where givenname: 'test' }

  it 'combines the provided the filter with the default' do
    directory.to_filter.should == "(&(objectCategory=person)(givenname=test))"
  end

  context 'chaining multiple or filters' do
    it 'nests the filters in pairs' do
      directory.or(sn: 'test').or(mail: 'test').to_filter.
        should == "(&(objectCategory=person)(|(|(givenname=test)(sn=test))(mail=test)))"
    end
  end
end