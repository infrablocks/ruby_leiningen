require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Uberjar do
  it 'calls the lein uberjar subcommand' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein uberjar', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'uberjar'
  it_behaves_like "a command with environment support", 'uberjar'

  it 'passes the provided main namespace as argument when specified' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein uberjar some.namespace', any_args))

    command.execute(main_namespace: 'some.namespace')
  end
end
