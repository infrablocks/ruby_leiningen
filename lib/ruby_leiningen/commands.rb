# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/string/inflections'

require_relative 'commands/helpers'
require_relative 'commands/check'
require_relative 'commands/clean'
require_relative 'commands/deps'
require_relative 'commands/run'
require_relative 'commands/uberjar'
require_relative 'commands/release'
require_relative 'commands/version'

module RubyLeiningen
  module Commands
    class << self
      def define_custom_command(name, options = {}, &)
        klass_name = name.classify
        klass = define_command_class(name, options, &)
        const_set(klass_name, klass)

        return if options[:skip_singleton_method]

        RubyLeiningen.define_singleton_method name do |opts = {}|
          klass.new.execute(opts)
        end
      end

      # rubocop:disable Metrics/MethodLength
      def define_command_class(name, options, &config_block)
        Class.new(Base) do
          unless options[:include_profile_support] == false
            include Mixins::Profile
          end
          unless options[:include_environment_support] == false
            include Mixins::Environment
          end
          define_method 'configure_command' do |builder, opts|
            config = (config_block || ->(conf, _) { conf })
                     .call(Config.new, opts)
            builder = super(builder, opts)
            builder = builder.with_subcommand(name) do |sub|
              config.subcommand_block.call(sub)
            end
            config.command_block.call(builder)
          end
        end
      end
      # rubocop:enable Metrics/MethodLength
    end

    class Config
      attr_accessor :command_block, :subcommand_block

      def initialize
        self.command_block = ->(command) { command }
        self.subcommand_block = ->(sub) { sub }
      end

      def on_command_builder(&block)
        self.command_block = block
        self
      end

      def on_subcommand_builder(&block)
        self.subcommand_block = block
        self
      end
    end
  end
end
