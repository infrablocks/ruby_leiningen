# frozen_string_literal: true

require_relative '../../commands'

RubyLeiningen::Commands.define_custom_command('eastwood') do |config, opts|
  config.on_command_builder do |command|
    command = command.with_argument("\"#{opts[:config]}\"") if opts[:config]
    command
  end
end
