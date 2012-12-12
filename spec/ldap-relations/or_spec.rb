require 'spec_helper'
require 'ldap-relations/or'

module Ldap::Relations
  describe Or do
    let(:left) { stub 'Relation', to_filter: '(name=test)' }
    let(:right) { stub 'Relation', to_filter: '(mail=test)' }
    let(:or_group) { Or.new left, right }

    describe '#to_filter' do
      subject { or_group.to_filter }

      it { should == "(|(name=test)(mail=test))" }
    end
  end
end