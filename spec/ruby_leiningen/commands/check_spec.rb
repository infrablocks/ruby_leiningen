require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Check do
  it 'calls the lein check subcommand' do
    command = RubyLeiningen::Commands::Check.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein check', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'check'
  it_behaves_like "a command with environment support", 'check'
end
