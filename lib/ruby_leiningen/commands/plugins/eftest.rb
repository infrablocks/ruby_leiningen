# frozen_string_literal: true

require_relative '../../commands'

RubyLeiningen::Commands.define_custom_command('eftest') do |config, opts|
  only = opts[:only] ? [":only #{opts[:only]}"] : []
  specific = (opts[:test_selectors] || [])
             .map { |m| m.is_a?(Symbol) ? ":#{m}" : m.to_s }
  all = [':all']

  test_selectors =
    if only.any?
      only
    elsif specific.any?
      specific
    else
      all
    end

  namespaces = opts[:namespaces] || []
  files = opts[:files] || []

  arguments = namespaces.concat(files).concat(test_selectors)

  config.on_command_builder do |command|
    arguments.inject(command) do |c, arg|
      c.with_argument(arg)
    end
  end
end
