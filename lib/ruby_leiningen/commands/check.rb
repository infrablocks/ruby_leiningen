require 'lino'

require_relative 'base'
require_relative 'mixins/profile'

module RubyLeiningen
  module Commands
    class Check < Base
      include Mixins::Profile

      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder.with_subcommand('check')
      end
    end
  end
end
