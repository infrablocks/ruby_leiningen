# frozen_string_literal: true

require 'spec_helper'

require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Version do
  it 'calls the lein version subcommand' do
    command = described_class.new(binary: 'lein')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with('lein version', any_args))
  end

  it_behaves_like('a command with environment support', 'version')
end
