# frozen_string_literal: true

require_relative '../../commands'

RubyLeiningen::Commands.define_custom_command('kibit') do |config, opts|
  paths = opts[:paths] || []

  config.on_subcommand_builder do |command|
    command = command.with_flag('--replace') if opts[:replace]
    command = command.with_flag('--interactive') if opts[:interactive]
    if opts[:reporter]
      command = command
                .with_option('--reporter', opts[:reporter])
    end
    command
  end
  config.on_command_builder do |subcommand|
    paths.inject(subcommand) do |s, path|
      s.with_argument(path)
    end
  end
end
