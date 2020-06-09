require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Clean do
  it 'calls the lein clean subcommand' do
    command = RubyLeiningen::Commands::Clean.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein clean', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'clean'
  it_behaves_like "a command with environment support", 'clean'
end
