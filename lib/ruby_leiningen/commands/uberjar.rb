require 'lino'

require_relative 'base'
require_relative 'mixins/profile'

module RubyLeiningen
  module Commands
    class Uberjar < Base
      include Mixins::Profile

      def configure_command(builder, opts)
        builder = super(builder, opts)

        main_namespace = opts[:main_namespace]

        builder = builder.with_subcommand('uberjar')
        builder = builder.with_argument(main_namespace) if main_namespace
        builder
      end
    end
  end
end
