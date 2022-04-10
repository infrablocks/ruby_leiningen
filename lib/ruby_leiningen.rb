# frozen_string_literal: true

require 'ruby_leiningen/version'
require 'ruby_leiningen/commands'

module RubyLeiningen
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset!
      @configuration = nil
    end
  end

  module ClassMethods
    def version
      Commands::Version.new.execute
    end

    def check(opts = {})
      Commands::Check.new.execute(opts)
    end

    def clean(opts = {})
      Commands::Clean.new.execute(opts)
    end

    def deps(opts = {})
      Commands::Deps.new.execute(opts)
    end

    def run(opts = {})
      Commands::Run.new.execute(opts)
    end

    def uberjar(opts = {})
      Commands::Uberjar.new.execute(opts)
    end

    def release(opts = {})
      Commands::Release.new.execute(opts)
    end
  end
  extend ClassMethods

  def self.included(other)
    other.extend(ClassMethods)
  end

  class Configuration
    attr_accessor :binary

    def initialize
      @binary = 'lein'
    end
  end
end
