# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/profile'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Release < Base
      include Mixins::Profile
      include Mixins::Environment

      def configure_command(initial_builder, opts)
        builder = super

        level = opts[:level]

        builder = builder.with_subcommand('release')
        builder = builder.with_argument(level) if level
        builder
      end
    end
  end
end
