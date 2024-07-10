# frozen_string_literal: true

require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Uberjar do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein uberjar subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein uberjar'))
  end

  it_behaves_like('a command with profile support', 'uberjar')
  it_behaves_like('a command with environment support', 'uberjar')

  it 'passes the provided main namespace as argument when specified' do
    command = described_class.new(binary: 'lein')

    command.execute(main_namespace: 'some.namespace')

    expect(executor.executions.first.command_line.string)
      .to(eq('lein uberjar some.namespace'))
  end
end
