# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/kibit'

describe RubyLeiningen::Commands::Kibit do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it_behaves_like('a command with profile support', 'kibit')
  it_behaves_like('a command with environment support', 'kibit')

  it 'calls the lein kibit subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein kibit'))
  end

  it 'passes the provided replace flag' do
    command = described_class.new(binary: 'lein')

    command.execute(replace: true)

    expect(executor.executions.first.command_line.string)
      .to(eq('lein kibit --replace'))
  end

  it 'passes the provided interactive flag' do
    command = described_class.new(binary: 'lein')

    command.execute(interactive: true)

    expect(executor.executions.first.command_line.string)
      .to(eq('lein kibit --interactive'))
  end

  it 'passes the provided reporter option' do
    command = described_class.new(binary: 'lein')

    command.execute(reporter: 'markdown')

    expect(executor.executions.first.command_line.string)
      .to(eq('lein kibit --reporter markdown'))
  end

  it 'passes the provided paths' do
    command = described_class.new(binary: 'lein')

    command.execute(paths: %w[src/some/file.clj src/other/file.clj])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein kibit src/some/file.clj src/other/file.clj'))
  end
end
