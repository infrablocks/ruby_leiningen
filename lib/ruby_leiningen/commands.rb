require 'active_support'
require 'active_support/core_ext/string/inflections'

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
      def define_custom_command(name, options = {}, &config_block)
        klass_name = name.classify

        klass = Class.new(Base) do
          unless options[:include_profile_support] == false
            include Mixins::Profile
          end

          define_method "configure_command" do |builder, opts|
            config = (config_block || lambda { |conf, _| conf })
                .call(Config.new, opts)

            builder = super(builder, opts)
            builder = builder.with_subcommand(name) do |sub|
              config.subcommand_block.call(sub)
            end
            config.command_block.call(builder)
          end
        end

        const_set(klass_name, klass)

        unless options[:skip_singleton_method]
          RubyLeiningen.define_singleton_method name do |opts = {}|
            klass.new.execute(opts)
          end
        end
      end
    end

    private

    class Config
      attr_accessor :command_block, :subcommand_block

      def initialize
        self.command_block = lambda { |command| command }
        self.subcommand_block = lambda { |sub| sub }
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
