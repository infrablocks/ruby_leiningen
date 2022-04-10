# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/bikeshed'

describe RubyLeiningen::Commands::Bikeshed do
  it 'calls the lein bikeshed subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed', any_args))
  end

  it_behaves_like('a command with profile support', 'bikeshed')
  it_behaves_like('a command with environment support', 'bikeshed')

  it 'passes the supplied show help flag' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(show_help: true)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --help-me', any_args))
  end

  it 'passes the supplied verbose flag' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(verbose: true)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --verbose', any_args))
  end

  it 'passes the supplied maximum line length' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(maximum_line_length: 120)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --max-line-length 120', any_args))
  end

  it 'passes the supplied long lines option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(long_lines: false)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --long-lines false', any_args))
  end

  it 'passes the supplied trailing whitespace option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(trailing_whitespace: false)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --trailing-whitespace false', any_args))
  end

  it 'passes the supplied trailing blank lines option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(trailing_blank_lines: false)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --trailing-blank-lines false', any_args))
  end

  it 'passes the supplied var redefs option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(var_redefs: false)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --var-redefs false', any_args))
  end

  it 'passes the supplied docstrings option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(docstrings: false)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --docstrings false', any_args))
  end

  it 'passes the supplied name collisions option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(name_collisions: false)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --name-collisions false', any_args))
  end

  it 'passes the supplied excluded profiles' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(exclude_profiles: %w[dev repl])

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein bikeshed --exclude-profiles dev,repl', any_args))
  end
end
