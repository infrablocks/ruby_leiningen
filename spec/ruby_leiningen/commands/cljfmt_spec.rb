# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/cljfmt'

describe RubyLeiningen::Commands::Cljfmt do
  it_behaves_like('a command with profile support', 'cljfmt', ['check'])
  it_behaves_like('a command with environment support', 'cljfmt', ['check'])

  it 'calls the lein cljfmt subcommand in check mode by default' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
        .with('lein cljfmt check', any_args))
  end

  it 'calls the lein cljfmt subcommand in fix mode when requested' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(mode: :fix)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein cljfmt fix', any_args))
  end

  it 'appends the supplied paths when provided' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(paths: %w[some/path some/other/path])

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein cljfmt check some/path some/other/path', any_args))
  end
end
