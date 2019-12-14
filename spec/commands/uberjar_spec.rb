require 'spec_helper'

describe RubyLeiningen::Commands::Uberjar do
  it 'calls the lein uberjar subcommand' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein uberjar', any_args))

    command.execute
  end

  it 'calls the lein uberjar subcommand for the profile provided at ' +
      'execution' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile uberjar', any_args))

    command.execute(profile: "some-profile")
  end

  it 'calls the lein uberjar subcommand for the profile previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile uberjar', any_args))

    command.execute
  end

  it 'prefers the profile passed at execution time over that previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile other-profile uberjar', any_args))

    command.execute(profile: 'other-profile')
  end

  it 'passes the provided main namespace as argument when specified' do
    command = RubyLeiningen::Commands::Uberjar.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein uberjar some.namespace', any_args))

    command.execute(main_namespace: 'some.namespace')
  end
end
