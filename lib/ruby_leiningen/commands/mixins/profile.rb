# frozen_string_literal: true

module RubyLeiningen
  module Commands
    module Mixins
      module Profile
        def initialize(opts = {})
          super(opts)
          @profile = opts[:profile]
        end

        def for_profile(profile)
          @profile = profile
          self
        end

        def configure_command(builder, opts)
          builder = super(builder, opts)
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
