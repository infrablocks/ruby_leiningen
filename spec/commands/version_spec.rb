require 'spec_helper'

describe RubyLeiningen::Commands::Version do
  it 'calls the lein version subcommand' do
    command = RubyLeiningen::Commands::Version.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein version', any_args))

    command.execute()
  end
end
