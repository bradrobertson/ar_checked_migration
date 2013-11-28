# ArCheckedMigration

[![Code Climate](https://codeclimate.com/repos/5297ae7f89af7e25a70ee800/badges/af6c4669ad4541ad1066/gpa.png)](https://codeclimate.com/repos/5297ae7f89af7e25a70ee800/feed)
[![Build Status](https://travis-ci.org/bradrobertson/ar_checked_migration.png?branch=master)](https://travis-ci.org/bradrobertson/ar_checked_migration)

ArCheckedMigration provides a utility for specifying which migrations to be run are
'safe' or not. It is up to you to specify in your migration whether or not it is safe.

Once each migration has done so, you can use the task below to determine if all
migrations to be run are safe, which would mean you wouldn't have to put your
application into maintenance mode during a deploy.

Safe Migrations are generally considered to be:

- New tables, columns, indexes
- Data changes

Unsafe Migrations include:

- table or column renames
- removing a table or column

## Installation

Add this line to your application's Gemfile:

    gem 'ar_checked_migration'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar_checked_migration

## Usage

To determine if your migrations to run are safe, you can simply run

````ruby
ArCheckedMigration::Runner.safe?
````

Note that if you're NOT using Rails, you'll need to manually specify the migrations
directories AND the schema_migrations table name before running the runner.
Something like:

````ruby
ArCheckedMigration::Runner.migrations = ActiveRecord::Migrator.migrations(['some', 'paths', 'here'])
ArCheckedMigration::Runner.table_name = 'schema_migrations'
ArCheckedMigration::Runner.safe?
````

Migrations themselves are a subclass of `ActiveRecord::CheckedMigration` instead of
`ActiveRecord::Migration`

A typical migration will look like

````ruby
class MyMigration < ActiveRecord::CheckedMigration
  # Set to true or false depending on the type of migration
  is_safe true

  def change
    # do some stuff
  end
end
````

If `is_safe` is not set or an `ActiveRecord::Migration` migration is used, it is assumed to be unsafe.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
