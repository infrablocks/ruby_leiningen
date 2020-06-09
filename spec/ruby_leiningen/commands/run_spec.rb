require 'spec_helper'

require_relative '../../support/shared_examples/profile_support'
require_relative '../../support/shared_examples/environment_support'

describe RubyLeiningen::Commands::Run do
  it 'calls the lein run subcommand' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein run', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'run'
  it_behaves_like "a command with environment support", 'run'

  it 'uses the provided main function when supplied' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein run -m some-namespace/main', any_args))

    command.execute(main_function: 'some-namespace/main')
  end

  it 'passes the provided arguments when supplied' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein run -- first second third', any_args))

    command.execute(arguments: ["first", "second", "third"])
  end

  it 'passes the --quote-args flaf when requested' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein run --quote-args -- first second third', any_args))

    command.execute(
        quote_arguments: true,
        arguments: ["first", "second", "third"])
  end
end
