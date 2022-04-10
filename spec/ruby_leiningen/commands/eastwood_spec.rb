# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/eastwood'

describe RubyLeiningen::Commands::Eastwood do
  it 'calls the lein eastwood subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
          .with('lein eastwood', any_args))
  end

  it_behaves_like 'a command with profile support', 'eastwood'
  it_behaves_like 'a command with environment support', 'eastwood'

  it 'passes the provided config spend supplied' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(config: '{:namespaces [mylib.core]}')

    expect(Open4)
      .to(have_received(:spawn)
          .with('lein eastwood "{:namespaces [mylib.core]}"', any_args))
  end
end
