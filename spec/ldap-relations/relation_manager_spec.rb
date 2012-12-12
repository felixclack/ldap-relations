require 'spec_helper'
require 'ldap-relations/relation_manager'

module Ldap::Relations
  describe RelationManager do
    let(:relation_manager) { RelationManager.new }
    let(:relation) { stub 'Relation', to_filter: '(objectCategory=person)' }
    let(:or_relation) { stub 'Or', to_filter: '(|(sAMAccountName=test)(mail=test))' }

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

      context 'with a Relation grouping' do
        before { relation_manager.relations << or_relation }

        it { should == "(|(sAMAccountName=test)(mail=test))" }
      end
    end
  end
end