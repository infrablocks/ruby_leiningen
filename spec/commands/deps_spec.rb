require 'spec_helper'

describe RubyLeiningen::Commands::Deps do
  it 'calls the lein deps subcommand' do
    command = RubyLeiningen::Commands::Deps.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein deps', any_args))

    command.execute
  end

  it 'calls the lein deps subcommand for the profile provided at execution' do
    command = RubyLeiningen::Commands::Deps.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile deps', any_args))

    command.execute(profile: "some-profile")
  end

  it 'calls the lein deps subcommand for the profile previously configured' do
    command = RubyLeiningen::Commands::Deps.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile deps', any_args))

    command.execute
  end

  it 'prefers the profile passed at execution time over that previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Deps.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile other-profile deps', any_args))

    command.execute(profile: 'other-profile')
  end
end
