# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/ruby_leiningen/commands/plugins/eftest'

describe RubyLeiningen::Commands::Eftest do
  it_behaves_like('a command with profile support', 'eftest', [':all'])
  it_behaves_like('a command with environment support', 'eftest', [':all'])

  it 'calls the lein eftest subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein eftest :all', any_args))
  end

  it 'passes the provided test selectors' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(test_selectors: %i[unit integration])

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein eftest :unit :integration', any_args))
  end

  it 'passes the provided namespaces' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(namespaces: %w[mylib.core mylib.helpers])

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein eftest mylib.core mylib.helpers :all', any_args))
  end

  it 'passes the provided files' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(files: %w[src/mylib/core.clj src/mylib/helpers.clj])

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              'lein eftest src/mylib/core.clj src/mylib/helpers.clj :all',
              any_args
            ))
  end

  it 'allows test selectors and namespaces' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(
      namespaces: %w[mylib.core mylib.helpers],
      test_selectors: %i[unit integration]
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              'lein eftest mylib.core mylib.helpers :unit :integration',
              any_args
            ))
  end

  it 'allows class based test selectors' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(
      namespaces: %w[mylib.core mylib.helpers],
      test_selectors: ['some.namespace/test-something', :integration]
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              'lein eftest mylib.core mylib.helpers '\
              'some.namespace/test-something :integration',
              any_args
            ))
  end

  it 'allows the only test selector' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(
      only: 'some.namespace/test-something'
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              'lein eftest :only some.namespace/test-something',
              any_args
            ))
  end
end
