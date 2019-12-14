require 'spec_helper'

describe RubyLeiningen::Commands::Clean do
  it 'calls the lein clean subcommand' do
    command = RubyLeiningen::Commands::Clean.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein clean', any_args))

    command.execute
  end

  it 'calls the lein clean subcommand for the profile provided at execution' do
    command = RubyLeiningen::Commands::Clean.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile clean', any_args))

    command.execute(profile: "some-profile")
  end

  it 'calls the lein clean subcommand for the profile previously configured' do
    command = RubyLeiningen::Commands::Clean.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile clean', any_args))

    command.execute
  end

  it 'prefers the profile passed at execution time over that previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Clean.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile other-profile clean', any_args))

    command.execute(profile: 'other-profile')
  end
end
