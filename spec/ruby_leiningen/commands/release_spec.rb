require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Release do
  it 'calls the lein release subcommand' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein release', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'release'
  it_behaves_like "a command with environment support", 'release'

  it 'passes the provided level as argument when specified' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein release :patch', any_args))

    command.execute(level: ':patch')
  end
end
