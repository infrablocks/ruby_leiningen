# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/profile'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Uberjar < Base
      include Mixins::Profile
      include Mixins::Environment

      def configure_command(initial_builder, opts)
        builder = super

        main_namespace = opts[:main_namespace]

        builder = builder.with_subcommand('uberjar')
        builder = builder.with_argument(main_namespace) if main_namespace
        builder
      end
    end
  end
end
