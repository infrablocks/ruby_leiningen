require 'lino'
require_relative 'base'

module RubyLeiningen
  module Commands
    class Run < Base
      def for_profile(profile)
        @profile = profile
        self
      end

      def configure_command(builder, opts)
        profile = opts[:profile] || @profile
        main_function = opts[:main_function]
        arguments = opts[:arguments] || []
        quote_arguments = opts[:quote_arguments]

        if profile
          builder = builder
              .with_subcommand('with-profile')
              .with_subcommand(profile)
        end

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
