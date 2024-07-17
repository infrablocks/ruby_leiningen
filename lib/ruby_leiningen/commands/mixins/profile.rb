# frozen_string_literal: true

module RubyLeiningen
  module Commands
    module Mixins
      module Profile
        def initialize(opts = {})
          super
          @profile = opts[:profile]
        end

        def for_profile(profile)
          @profile = profile
          self
        end

        def configure_command(initial_builder, opts)
          builder = super
          profile = opts[:profile] || @profile
          if profile
            builder = builder
                      .with_subcommand('with-profile')
                      .with_subcommand(profile)
          end
          builder
        end
      end
    end
  end
end
