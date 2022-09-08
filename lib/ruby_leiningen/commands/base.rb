# frozen_string_literal: true

require 'lino'

module RubyLeiningen
  module Commands
    class Base
      attr_reader :binary

      def initialize(opts = {})
        @binary = opts[:binary] || RubyLeiningen.configuration.binary
      end

      def stdin
        ''
      end

      def stdout
        $stdout
      end

      def stderr
        $stderr
      end

      def execute(opts = {})
        do_before(opts)
        configure_command(instantiate_builder, opts)
          .build
          .execute(stdin: stdin, stdout: stdout, stderr: stderr)
        do_after(opts)
      end

      def instantiate_builder
        Lino::CommandLineBuilder
          .for_command(binary)
      end

      def do_before(opts); end

      def configure_command(builder, _opts)
        builder
      end

      def do_after(opts); end
    end
  end
end
