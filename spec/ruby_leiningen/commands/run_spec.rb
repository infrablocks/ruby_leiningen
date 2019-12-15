require 'spec_helper'

describe RubyLeiningen::Commands::Run do
  it 'calls the lein run subcommand' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein run', any_args))

    command.execute
  end

  it 'calls the lein run subcommand for the profile provided at execution' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile run', any_args))

    command.execute(profile: "some-profile")
  end

  it 'calls the lein run subcommand for the profile previously configured' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile run', any_args))

    command.execute
  end

  it 'prefers the profile passed at execution time over that previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Run.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile other-profile run', any_args))

    command.execute(profile: 'other-profile')
  end

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
