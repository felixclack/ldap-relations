require 'spec_helper'
require 'ldap-relations/relation_manager'

module Ldap::Relations
  describe RelationManager do
    let(:relation_manager) { RelationManager.new }
    let(:relation) { stub 'Relation', to_filter: 'objectCategory=person', operator: :and }
    let(:or_relation) { stub 'Relation', to_filter: 'sAMAccountName=test', operator: :or }

    describe '#relations' do
      it 'stores a list of relations' do
        relation_manager.relations << relation << relation
        relation_manager.relations.should == [relation, relation]
      end
    end

    describe '#to_filter' do
      subject { relation_manager.to_filter }

      context 'with one relation' do
        before { relation_manager.relations << relation }

        it { should == "(objectCategory=person)" }
      end

      context 'with 2 relations' do
        before { relation_manager.relations << relation << relation }

        it { should == "(&(objectCategory=person)(objectCategory=person))" }
      end

      context 'with an AND relation and an OR relation' do
        before { relation_manager.relations << relation << or_relation }

        it { should == "(|(objectCategory=person)(sAMAccountName=test))"}
      end
    end
  end
end