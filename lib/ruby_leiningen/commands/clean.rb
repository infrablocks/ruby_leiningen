require 'lino'

require_relative 'base'
require_relative 'mixins/profile'

module RubyLeiningen
  module Commands
    class Clean < Base
      include Mixins::Profile

      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder.with_subcommand('clean')
      end
    end
  end
end
