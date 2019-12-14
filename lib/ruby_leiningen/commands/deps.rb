require 'lino'
require_relative 'base'

module RubyLeiningen
  module Commands
    class Deps < Base
      def for_profile(profile)
        @profile = profile
        self
      end

      def configure_command(builder, opts)
        profile = opts[:profile] || @profile
        if profile
          builder = builder
              .with_subcommand('with-profile')
              .with_subcommand(profile)
        end
        builder.with_subcommand('deps')
      end
    end
  end
end
