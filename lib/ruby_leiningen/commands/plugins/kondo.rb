require_relative '../../commands'

RubyLeiningen::Commands.define_custom_command("kondo") do |config, opts|
  path = opts[:path]
  cache_directory = opts[:cache_directory]
  cache = opts[:cache]
  config_dir = opts[:config_dir]
  parallel = opts[:parallel]
  fail_level = opts[:fail_level]

  config.on_subcommand_builder do |command|
    unless path.nil?
      command = command.with_option('--lint', path)
    end
    unless cache_directory.nil?
      command = command.with_option('--cache-dir', cache_directory)
    end
    unless cache.nil?
      command = command.with_flag('--cache')
    end
    unless config_dir.nil?
      command = command.with_option('--config-dir', config_dir)
    end
    unless parallel.nil?
      command = command.with_flag('--parallel')
    end
    unless fail_level.nil?
      command = command.with_option('--fail-level', fail_level)
    end
    command
  end
end
