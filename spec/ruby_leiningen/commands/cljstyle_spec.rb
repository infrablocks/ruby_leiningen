# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/cljstyle'

describe RubyLeiningen::Commands::Cljstyle do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein cljstyle subcommand in check mode by default' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein cljstyle check'))
  end

  it 'calls the lein cljstyle subcommand in fix mode when requested' do
    command = described_class.new(binary: 'lein')

    command.execute(mode: :fix)

    expect(executor.executions.first.command_line.string)
      .to(eq('lein cljstyle fix'))
  end

  it 'appends the supplied paths when provided' do
    command = described_class.new(binary: 'lein')

    command.execute(paths: %w[some/path some/other/path])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein cljstyle check some/path some/other/path'))
  end
end
