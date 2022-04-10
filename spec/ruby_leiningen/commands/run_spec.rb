# frozen_string_literal: true

require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Run do
  it 'calls the lein run subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein run', any_args))
  end

  it_behaves_like('a command with profile support', 'run')
  it_behaves_like('a command with environment support', 'run')

  it 'uses the provided main function when supplied' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(main_function: 'some-namespace/main')

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein run -m some-namespace/main', any_args))
  end

  it 'passes the provided arguments when supplied' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(arguments: %w[first second third])

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein run -- first second third', any_args))
  end

  it 'passes the --quote-args flaf when requested' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(
      quote_arguments: true,
      arguments: %w[first second third]
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein run --quote-args -- first second third', any_args))
  end
end
