require 'ruby_leiningen/version'
require 'ruby_leiningen/commands'

module RubyLeiningen
  class << self
    attr_accessor :configuration

    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

    def reset!
      @configuration = nil
    end
  end

  module ClassMethods
    def version
      Commands::Version.new.execute
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
