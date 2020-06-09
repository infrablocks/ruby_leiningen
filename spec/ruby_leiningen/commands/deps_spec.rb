require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Deps do
  it 'calls the lein deps subcommand' do
    command = RubyLeiningen::Commands::Deps.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein deps', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'deps'
  it_behaves_like "a command with environment support", 'deps'
end
