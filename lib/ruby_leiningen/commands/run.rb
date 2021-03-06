require 'lino'

require_relative 'base'
require_relative 'mixins/profile'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Run < Base
      include Mixins::Profile
      include Mixins::Environment

      def configure_command(builder, opts)
        builder = super(builder, opts)

        main_function = opts[:main_function]
        arguments = opts[:arguments] || []
        quote_arguments = opts[:quote_arguments]

        builder = builder.with_subcommand('run') do |sub|
          sub = sub.with_option('-m', main_function) if main_function
          sub = sub.with_flag('--quote-args') if quote_arguments
          sub
        end

        if arguments.any?
          builder = builder.with_argument("--")
          builder = arguments.inject(builder) do |b, argument|
            b.with_argument(argument)
          end
        end

        builder
      end
    end
  end
end
