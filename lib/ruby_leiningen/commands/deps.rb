# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/profile'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Deps < Base
      include Mixins::Profile
      include Mixins::Environment

      def configure_command(builder, opts)
        builder = super(builder, opts)
        builder.with_subcommand('deps')
      end
    end
  end
end
