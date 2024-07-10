# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/eastwood'

describe RubyLeiningen::Commands::Eastwood do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein eastwood subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eastwood'))
  end

  it_behaves_like 'a command with profile support', 'eastwood'
  it_behaves_like 'a command with environment support', 'eastwood'

  it 'passes the provided config spend supplied' do
    command = described_class.new(binary: 'lein')

    command.execute(config: '{:namespaces [mylib.core]}')

    expect(executor.executions.first.command_line.string)
      .to(eq('lein eastwood "{:namespaces [mylib.core]}"'))
  end
end
