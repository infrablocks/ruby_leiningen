require 'lino'

require_relative 'base'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Version < Base
      include Mixins::Environment

      def stdout
        @version_string
      end

      def do_before(opts)
        @version_string = StringIO.new
      end

      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder.with_argument('version')
      end

      def do_after(opts)
        @version_string.string.gsub(/\n/, '')
      end
    end
  end
end
