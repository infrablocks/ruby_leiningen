# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/bikeshed'

describe RubyLeiningen::Commands::Bikeshed do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'calls the lein bikeshed subcommand' do
    command = described_class.new(binary: 'lein')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('lein bikeshed'))
  end

  it_behaves_like('a command with profile support', 'bikeshed')
  it_behaves_like('a command with environment support', 'bikeshed')

  it 'passes the supplied show help flag' do
    command = described_class.new(binary: 'lein')

    command.execute(show_help: true)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --help-me'))
  end

  it 'passes the supplied verbose flag' do
    command = described_class.new(binary: 'lein')

    command.execute(verbose: true)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --verbose'))
  end

  it 'passes the supplied maximum line length' do
    command = described_class.new(binary: 'lein')

    command.execute(maximum_line_length: 120)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --max-line-length 120'))
  end

  it 'passes the supplied long lines option' do
    command = described_class.new(binary: 'lein')

    command.execute(long_lines: false)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --long-lines false'))
  end

  it 'passes the supplied trailing whitespace option' do
    command = described_class.new(binary: 'lein')

    command.execute(trailing_whitespace: false)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --trailing-whitespace false'))
  end

  it 'passes the supplied trailing blank lines option' do
    command = described_class.new(binary: 'lein')

    command.execute(trailing_blank_lines: false)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --trailing-blank-lines false'))
  end

  it 'passes the supplied var redefs option' do
    command = described_class.new(binary: 'lein')

    command.execute(var_redefs: false)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --var-redefs false'))
  end

  it 'passes the supplied docstrings option' do
    command = described_class.new(binary: 'lein')

    command.execute(docstrings: false)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --docstrings false'))
  end

  it 'passes the supplied name collisions option' do
    command = described_class.new(binary: 'lein')

    command.execute(name_collisions: false)

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --name-collisions false'))
  end

  it 'passes the supplied excluded profiles' do
    command = described_class.new(binary: 'lein')

    command.execute(exclude_profiles: %w[dev repl])

    expect(executor.executions.first.command_line.string)
      .to(match('lein bikeshed --exclude-profiles dev,repl'))
  end
end
