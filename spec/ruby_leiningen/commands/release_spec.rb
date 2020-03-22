require 'spec_helper'

describe RubyLeiningen::Commands::Release do
  it 'calls the lein release subcommand' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein release', any_args))

    command.execute
  end

  it 'calls the lein release subcommand for the profile provided at ' +
      'execution' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile release', any_args))

    command.execute(profile: "some-profile")
  end

  it 'calls the lein release subcommand for the profile previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile some-profile release', any_args))

    command.execute
  end

  it 'prefers the profile passed at execution time over that previously ' +
      'configured' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')
        .for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with('lein with-profile other-profile release', any_args))

    command.execute(profile: 'other-profile')
  end

  it 'passes the provided level as argument when specified' do
    command = RubyLeiningen::Commands::Release.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein release :patch', any_args))

    command.execute(level: ':patch')
  end
end
