# frozen_string_literal: true

require_relative '../../commands'

RubyLeiningen::Commands.define_custom_command('cljstyle') do |config, opts|
  mode = opts[:mode] || :check
  paths = opts[:paths] || []

  config.on_command_builder do |command|
    command = command.with_subcommand(mode.to_s)
    paths.inject(command) do |c, path|
      c.with_argument(path)
    end
  end
end
