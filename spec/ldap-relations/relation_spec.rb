require 'spec_helper'
require 'ldap-relations/relation'

module Ldap::Relations
  describe Relation do
    let(:relation) { Relation.new sAMAccountName: 'test' }

    subject { relation }

    its(:params) { should == { sAMAccountName: 'test'} }

    describe '#to_filter' do
      subject { relation.to_filter }

      it { should == '(sAMAccountName=test)' }
    end
  end
end