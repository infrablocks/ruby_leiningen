# frozen_string_literal: true

require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Uberjar do
  it 'calls the lein uberjar subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein uberjar', any_args))
  end

  it_behaves_like('a command with profile support', 'uberjar')
  it_behaves_like('a command with environment support', 'uberjar')

  it 'passes the provided main namespace as argument when specified' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute(main_namespace: 'some.namespace')

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein uberjar some.namespace', any_args))
  end
end
