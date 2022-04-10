# frozen_string_literal: true

require 'spec_helper'

describe RubyLeiningen::Commands::Release do
  it 'calls the lein release subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein release', any_args))
  end

  it_behaves_like('a command with profile support', 'release')
  it_behaves_like('a command with environment support', 'release')

  it 'passes the provided level as argument when specified' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(level: ':patch')

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein release :patch', any_args))
  end
end
