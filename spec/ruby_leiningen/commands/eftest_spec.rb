# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/eftest'

describe RubyLeiningen::Commands::Eftest do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it_behaves_like('a command with profile support', 'eftest', [':all'])
  it_behaves_like('a command with environment support', 'eftest', [':all'])

  it 'calls the lein eftest subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest :all'))
  end

  it 'passes the provided test selectors' do
    command = described_class.new(binary: 'lein')

    command.execute(test_selectors: %i[unit integration])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest :unit :integration'))
  end

  it 'passes the provided namespaces' do
    command = described_class.new(binary: 'lein')

    command.execute(namespaces: %w[mylib.core mylib.helpers])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest mylib.core mylib.helpers :all'))
  end

  it 'passes the provided files' do
    command = described_class.new(binary: 'lein')

    command.execute(files: %w[src/mylib/core.clj src/mylib/helpers.clj])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest src/mylib/core.clj src/mylib/helpers.clj :all'))
  end

  it 'allows test selectors and namespaces' do
    command = described_class.new(binary: 'lein')

    command.execute(
      namespaces: %w[mylib.core mylib.helpers],
      test_selectors: %i[unit integration]
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest mylib.core mylib.helpers :unit :integration'))
  end

  it 'allows class based test selectors' do
    command = described_class.new(binary: 'lein')

    command.execute(
      namespaces: %w[mylib.core mylib.helpers],
      test_selectors: ['some.namespace/test-something', :integration]
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest mylib.core mylib.helpers ' \
             'some.namespace/test-something :integration'))
  end

  it 'allows the only test selector' do
    command = described_class.new(binary: 'lein')

    command.execute(
      only: 'some.namespace/test-something'
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eftest :only some.namespace/test-something'))
  end
end
