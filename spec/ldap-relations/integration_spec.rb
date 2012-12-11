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
    manager.relations << LRel::Relation.new(objectCategory: 'person')
  end

  attr_accessor :manager

  def where params
    params.each do |k, v|
      manager.relations << LRel::Relation.new("#{k}" => v)
    end
    self
  end

  def all
    perform
  end

  private
    def perform
      manager.to_filter
    end
end

describe "integration" do
  let(:directory) { Directory.where givenname: 'test' }

  it 'combines the provided the filter with the default' do
    directory.all.should == "(&(objectCategory=person)(givenname=test))"
  end
end