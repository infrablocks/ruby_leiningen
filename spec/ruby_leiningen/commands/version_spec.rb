# frozen_string_literal: true

require 'spec_helper'

require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Version do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein version subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein version'))
  end

  it_behaves_like('a command with environment support', 'version')
end
