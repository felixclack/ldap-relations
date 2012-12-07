# Ldap::Relations

[![Build Status](https://travis-ci.org/felixclack/ldap-relations.png)](https://travis-ci.org/felixclack/ldap-relations)

An Arel inspired library to provide a relational algebra for LDAP filters.
I'm using it in conjunction with the jruby-ldap library because the 
ruby ldap libraries just don't cut it in Ruby 1.9.

## Installation

Add this line to your application's Gemfile:

    gem 'ldap-relations'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ldap-relations

## Usage

Create a relation manager first...

    manager = Ldap::Relations::RelationManager.new

    manager.relations << Relation.new(sAMAccountName: 'test')
    manager.relations << Relation.new(objectCategory: 'person')

    manager.to_filter #=> "(&(sAMAccountName=test)(objectCategory=person)"

Then pass that filter string into the search method on your LDAP connection. Simples.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
