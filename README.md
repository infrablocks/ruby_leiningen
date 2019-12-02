# RubyLeiningen

Wraps the leiningen CLI so that leiningen can be invoked from a Ruby script or 
Rakefile.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_leiningen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_leiningen

## Usage

### Binary Location

RubyLeiningen needs to know where the lein command is located before it can do 
anything. By default, RubyLeiningen looks on the path however this can be 
configured with:

```ruby
RubyLeiningen.configure do |config|
  config.binary = 'vendor/leiningen/bin/lein'
end
```

In addition, each command takes a `binary` keyword argument at initialisation
that overrides the global configuration value.

### Commands

Currently, there is partial support for the following commands:
* `RubyLeiningen::Commands::Deps`:
* `RubyLeiningen::Commands::Version`: returns the version of the leiningen 
  binary

#### `RubyLeiningen::Commands::Deps`

The deps command can be called in the following ways:

```ruby
RubyLeiningen.deps
RubyLeiningen::Commands::Deps.new.execute
```

#### `RubyLeiningen::Commands::Version`

The version command can be called in the following ways:

```ruby
version = RubyLeiningen.version
version = RubyLeiningen::Commands::Version.new.execute
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to 
[rubygems.org](https://rubygems.org).

### Managing CircleCI keys

To encrypt a GPG key for use by CircleCI:

```bash
openssl aes-256-cbc \
  -e \
  -md sha1 \
  -in ./config/secrets/ci/gpg.private \
  -out ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

To check decryption is working correctly:

```bash
openssl aes-256-cbc \
  -d \
  -md sha1 \
  -in ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at 
https://github.com/infrablocks/ruby_leiningen. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to 
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of 
conduct.


## License

The gem is available as open source under the terms of the 
[MIT License](http://opensource.org/licenses/MIT).
