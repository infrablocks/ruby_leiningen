# frozen_string_literal: true

require_relative '../../commands'

module RubyLeiningen
  module Commands
    module Helpers
      module Bikeshed
        class << self
          def with_show_help(command, show_help)
            return command if show_help.nil?

            command.with_flag(show_help ? '--help-me' : '--no-help-me')
          end

          def with_verbose(command, verbose)
            return command if verbose.nil?

            command.with_flag(verbose ? '--verbose' : '--no-verbose')
          end

          def with_maximum_line_length(command, maximum_line_length)
            return command unless maximum_line_length

            command.with_option('--max-line-length', maximum_line_length)
          end

          def with_long_lines(command, long_lines)
            return command if long_lines.nil?

            command.with_option('--long-lines', long_lines)
          end

          def with_trailing_whitespace(command, trailing_whitespace)
            return command if trailing_whitespace.nil?

            command.with_option('--trailing-whitespace', trailing_whitespace)
          end

          def with_trailing_blank_lines(command, trailing_blank_lines)
            return command if trailing_blank_lines.nil?

            command.with_option('--trailing-blank-lines', trailing_blank_lines)
          end

          def with_var_redefs(command, var_redefs)
            return command if var_redefs.nil?

            command.with_option('--var-redefs', var_redefs)
          end

          def with_docstrings(command, docstrings)
            return command if docstrings.nil?

            command.with_option('--docstrings', docstrings)
          end

          def with_name_collisions(command, name_collisions)
            return command if name_collisions.nil?

            command.with_option('--name-collisions', name_collisions)
          end

          def with_exclude_profiles(command, exclude_profiles)
            return command if exclude_profiles.nil?

            command.with_option(
              '--exclude-profiles', exclude_profiles.join(',')
            )
          end
        end
      end
    end
  end
end

RubyLeiningen::Commands.define_custom_command('bikeshed') do |config, opts|
  helper = RubyLeiningen::Commands::Helpers::Bikeshed

  config.on_subcommand_builder do |sub|
    sub = helper.with_show_help(sub, opts[:show_help])
    sub = helper.with_verbose(sub, opts[:verbose])
    sub = helper.with_maximum_line_length(sub, opts[:maximum_line_length])
    sub = helper.with_long_lines(sub, opts[:long_lines])
    sub = helper.with_trailing_whitespace(sub, opts[:trailing_whitespace])
    sub = helper.with_trailing_blank_lines(sub, opts[:trailing_blank_lines])
    sub = helper.with_var_redefs(sub, opts[:var_redefs])
    sub = helper.with_docstrings(sub, opts[:docstrings])
    sub = helper.with_name_collisions(sub, opts[:name_collisions])
    sub = helper.with_exclude_profiles(sub, opts[:exclude_profiles])
    sub
  end
end
