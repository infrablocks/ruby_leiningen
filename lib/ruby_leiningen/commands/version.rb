# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Version < Base
      include Mixins::Environment

      def invocation_option_defaults(_invocation_options)
        super.merge(capture: [:stdout])
      end

      def configure_command(initial_builder, opts)
        builder = super
        builder.with_argument('version')
      end

      def process_result(result, _parameters, _invocation_options)
        output = result[:output]
        output.gsub("\n", '')
      end
    end
  end
end
