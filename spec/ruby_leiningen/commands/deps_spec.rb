# frozen_string_literal: true

require 'spec_helper'

describe RubyLeiningen::Commands::Deps do
  it 'calls the lein deps subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
        .with('lein deps', any_args))
  end

  it_behaves_like('a command with profile support', 'deps')
  it_behaves_like('a command with environment support', 'deps')
end
