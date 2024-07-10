# frozen_string_literal: true

require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Run do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein run subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein run'))
  end

  it_behaves_like('a command with profile support', 'run')
  it_behaves_like('a command with environment support', 'run')

  it 'uses the provided main function when supplied' do
    command = described_class.new(binary: 'lein')

    command.execute(main_function: 'some-namespace/main')

    expect(executor.executions.first.command_line.string)
      .to(eq('lein run -m some-namespace/main'))
  end

  it 'passes the provided arguments when supplied' do
    command = described_class.new(binary: 'lein')

    command.execute(arguments: %w[first second third])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein run -- first second third'))
  end

  it 'passes the --quote-args flaf when requested' do
    command = described_class.new(binary: 'lein')

    command.execute(
      quote_arguments: true,
      arguments: %w[first second third]
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('lein run --quote-args -- first second third'))
  end
end
