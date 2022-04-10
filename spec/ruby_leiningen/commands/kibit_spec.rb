# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/kibit'

describe RubyLeiningen::Commands::Kibit do
  it_behaves_like('a command with profile support', 'kibit')
  it_behaves_like('a command with environment support', 'kibit')

  it 'calls the lein kibit subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein kibit', any_args))
  end

  it 'passes the provided replace flag' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(replace: true)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein kibit --replace', any_args))
  end

  it 'passes the provided interactive flag' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(interactive: true)

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein kibit --interactive', any_args))
  end

  it 'passes the provided reporter option' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(reporter: 'markdown')

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein kibit --reporter markdown', any_args))
  end

  it 'passes the provided paths' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(paths: %w[src/some/file.clj src/other/file.clj])

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein kibit src/some/file.clj src/other/file.clj', any_args))
  end
end
