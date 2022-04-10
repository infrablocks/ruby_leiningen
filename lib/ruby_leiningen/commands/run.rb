# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/profile'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Run < Base
      include Mixins::Profile
      include Mixins::Environment

      # rubocop:disable Style/RedundantAssignment
      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder = builder.with_subcommand('run') do |sub|
          sub = with_main_function(sub, opts[:main_function])
          sub = with_quote_arguments(sub, opts[:quote_arguments])
          sub
        end
        builder = with_arguments(builder, opts[:arguments])
        builder
      end
      # rubocop:enable Style/RedundantAssignment

      private

      def with_arguments(builder, arguments)
        arguments ||= []
        if arguments.any?
          builder = builder.with_argument('--')
          builder = arguments.inject(builder) do |b, argument|
            b.with_argument(argument)
          end
        end
        builder
      end

      def with_main_function(builder, main_function)
        return builder unless main_function

        builder.with_option('-m', main_function)
      end

      def with_quote_arguments(builder, quote_arguments)
        return builder unless quote_arguments

        builder.with_flag('--quote-args')
      end
    end
  end
end
