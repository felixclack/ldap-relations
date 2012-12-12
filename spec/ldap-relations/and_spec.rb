require 'spec_helper'
require 'ldap-relations/and'

module Ldap::Relations
  describe And do
    let(:left) { stub 'Relation', to_filter: '(user=test)' }
    let(:right) { stub 'Relation', to_filter: '(mail=test)' }
    let(:and_group) { And.new left, right }

    describe '#to_filter' do
      subject { and_group.to_filter }

      it { should == '(&(user=test)(mail=test))' }
    end
  end
end