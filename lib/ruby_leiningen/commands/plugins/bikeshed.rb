require_relative '../../commands'

RubyLeiningen::Commands.define_custom_command("bikeshed") do |config, opts|
  show_help = opts[:show_help]
  verbose = opts[:verbose]
  maximum_line_length = opts[:maximum_line_length]
  long_lines = opts[:long_lines]
  trailing_whitespace = opts[:trailing_whitespace]
  trailing_blank_lines = opts[:trailing_blank_lines]
  var_redefs = opts[:var_redefs]
  docstrings = opts[:docstrings]
  name_collisions = opts[:name_collisions]
  exclude_profiles = opts[:exclude_profiles]

  config.on_subcommand_builder do |command|
    unless show_help.nil?
      command = command.with_flag(show_help ? '--help-me' : '--no-help-me')
    end
    unless verbose.nil?
      command = command.with_flag(verbose ? '--verbose' : '--no-verbose')
    end
    if maximum_line_length
      command = command.with_option('--max-line-length', maximum_line_length)
    end
    unless long_lines.nil?
      command = command.with_option('--long-lines', long_lines)
    end
    unless trailing_whitespace.nil?
      command = command
          .with_option('--trailing-whitespace', trailing_whitespace)
    end
    unless trailing_blank_lines.nil?
      command = command
          .with_option('--trailing-blank-lines', trailing_blank_lines)
    end
    unless var_redefs.nil?
      command = command.with_option('--var-redefs', var_redefs)
    end
    unless docstrings.nil?
      command = command.with_option('--docstrings', docstrings)
    end
    unless name_collisions.nil?
      command = command.with_option('--name-collisions', name_collisions)
    end
    unless exclude_profiles.nil?
      command = command
          .with_option('--exclude-profiles', exclude_profiles.join(","))
    end
    command
  end
end
