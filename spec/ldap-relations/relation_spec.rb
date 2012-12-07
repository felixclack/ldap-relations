require 'spec_helper'
require 'ldap-relations/relation'

module Ldap::Relations
  describe Relation do
    let(:relation) { Relation.new sAMAccountName: 'test' }

    subject { relation }

    its(:params) { should == { sAMAccountName: 'test'} }

    describe '#to_filter' do
      subject { relation.to_filter }

      it { should == 'sAMAccountName=test' }
    end

    describe '#operator' do
      context 'by default' do
        subject { relation.operator }

        it { should == :and }
      end

      context 'when set to :or' do
        let(:or_relation) { Relation.new sAMAccountName: 'test', operator: :or }

        subject { or_relation.operator }

        it { should == :or }
      end
    end
  end
end