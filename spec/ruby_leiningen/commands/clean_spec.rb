# frozen_string_literal: true

require 'spec_helper'

describe RubyLeiningen::Commands::Clean do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein clean subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein clean'))
  end

  it_behaves_like('a command with profile support', 'clean')
  it_behaves_like('a command with environment support', 'clean')
end
