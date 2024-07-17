# frozen_string_literal: true

require 'lino'

require_relative 'base'
require_relative 'mixins/profile'
require_relative 'mixins/environment'

module RubyLeiningen
  module Commands
    class Clean < Base
      include Mixins::Profile
      include Mixins::Environment

      def configure_command(initial_builder, opts)
        builder = super
        builder.with_subcommand('clean')
      end
    end
  end
end
