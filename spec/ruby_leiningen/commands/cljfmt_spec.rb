# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/cljfmt'

describe RubyLeiningen::Commands::Cljfmt do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it_behaves_like('a command with profile support', 'cljfmt', ['check'])
  it_behaves_like('a command with environment support', 'cljfmt', ['check'])

  it 'calls the lein cljfmt subcommand in check mode by default' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein cljfmt check'))
  end

  it 'calls the lein cljfmt subcommand in fix mode when requested' do
    command = described_class.new(binary: 'lein')

    command.execute(mode: :fix)

    expect(executor.executions.first.command_line.string)
      .to(eq('lein cljfmt fix'))
  end

  it 'appends the supplied paths when provided' do
    command = described_class.new(binary: 'lein')

    command.execute(paths: %w[some/path some/other/path])

    expect(executor.executions.first.command_line.string)
      .to(eq('lein cljfmt check some/path some/other/path'))
  end
end
