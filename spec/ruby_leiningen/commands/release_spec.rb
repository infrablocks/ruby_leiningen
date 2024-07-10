# frozen_string_literal: true

require 'spec_helper'

describe RubyLeiningen::Commands::Release do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein release subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein release'))
  end

  it_behaves_like('a command with profile support', 'release')
  it_behaves_like('a command with environment support', 'release')

  it 'passes the provided level as argument when specified' do
    command = described_class.new(binary: 'lein')

    command.execute(level: ':patch')

    expect(executor.executions.first.command_line.string)
      .to(eq('lein release :patch'))
  end
end
