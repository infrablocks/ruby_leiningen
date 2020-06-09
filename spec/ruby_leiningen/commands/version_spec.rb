require 'spec_helper'

require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Version do
  it 'calls the lein version subcommand' do
    command = RubyLeiningen::Commands::Version.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein version', any_args))

    command.execute
  end

  it_behaves_like "a command with environment support", 'version'
end
