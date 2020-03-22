require 'spec_helper'

require_relative '../lib/ruby_leiningen/commands/plugins/bikeshed'
require_relative '../lib/ruby_leiningen/commands/plugins/cljfmt'
require_relative '../lib/ruby_leiningen/commands/plugins/eastwood'
require_relative '../lib/ruby_leiningen/commands/plugins/eftest'
require_relative '../lib/ruby_leiningen/commands/plugins/kibit'

RSpec.describe RubyLeiningen do
  it 'has a version number' do
    expect(RubyLeiningen::VERSION).not_to be nil
  end

  it 'exposes a check helper function' do
    profile = 'test'

    check_command = double('check command')

    expect(RubyLeiningen::Commands::Check)
        .to(receive(:new).and_return(check_command))
    expect(check_command)
        .to(receive(:execute).with(profile: profile))

    RubyLeiningen.check(profile: profile)
  end

  it 'exposes a clean helper function' do
    profile = 'test'

    clean_command = double('clean command')

    expect(RubyLeiningen::Commands::Clean)
        .to(receive(:new).and_return(clean_command))
    expect(clean_command)
        .to(receive(:execute).with(profile: profile))

    RubyLeiningen.clean(profile: profile)
  end

  it 'exposes a deps helper function' do
    profile = 'test'

    deps_command = double('deps command')

    expect(RubyLeiningen::Commands::Deps)
        .to(receive(:new).and_return(deps_command))
    expect(deps_command)
        .to(receive(:execute).with(profile: profile))

    RubyLeiningen.deps(profile: profile)
  end

  it 'exposes a run helper function' do
    profile = 'test'
    main_function = 'mything.core/main'

    run_command = double('run command')

    expect(RubyLeiningen::Commands::Run)
        .to(receive(:new).and_return(run_command))
    expect(run_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                main_function: main_function))

    RubyLeiningen.run(profile: profile, main_function: main_function)
  end

  it 'exposes an uberjar helper function' do
    profile = 'test'
    main_namespace = 'mything.core'

    uberjar_command = double('uberjar command')

    expect(RubyLeiningen::Commands::Uberjar)
        .to(receive(:new).and_return(uberjar_command))
    expect(uberjar_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                main_namespace: main_namespace))

    RubyLeiningen.uberjar(
        profile: profile,
        main_namespace: main_namespace)
  end

  it 'exposes a release helper function' do
    profile = 'prerelease'
    level = ':patch'

    release_command = double('release command')

    expect(RubyLeiningen::Commands::Release)
        .to(receive(:new).and_return(release_command))
    expect(release_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                level: level))

    RubyLeiningen.release(
        profile: profile,
        level: level)
  end

  it 'exposes a bikeshed helper function when bikeshed plugin required' do
    profile = 'test'
    maximum_line_length = 80

    bikeshed_command = double('bikeshed command')

    expect(RubyLeiningen::Commands::Bikeshed)
        .to(receive(:new).and_return(bikeshed_command))
    expect(bikeshed_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                maximum_line_length: maximum_line_length))

    RubyLeiningen.bikeshed(
        profile: profile,
        maximum_line_length: maximum_line_length)
  end

  it 'exposes a cljfmt helper function when cljfmt plugin required' do
    profile = 'test'
    mode = :fix

    cljfmt_command = double('cljfmt command')

    expect(RubyLeiningen::Commands::Cljfmt)
        .to(receive(:new).and_return(cljfmt_command))
    expect(cljfmt_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                mode: mode))

    RubyLeiningen.cljfmt(
        profile: profile,
        mode: mode)
  end

  it 'exposes an eastwood helper function when eastwood plugin required' do
    profile = 'test'

    eastwood_command = double('eastwood command')

    expect(RubyLeiningen::Commands::Eastwood)
        .to(receive(:new).and_return(eastwood_command))
    expect(eastwood_command)
        .to(receive(:execute)
            .with(profile: profile))

    RubyLeiningen.eastwood(profile: profile)
  end

  it 'exposes an eftest helper function when eftest plugin required' do
    profile = 'test'
    namespaces = ["first.namespace", "second.namespace"]

    eftest_command = double('eftest command')

    expect(RubyLeiningen::Commands::Eftest)
        .to(receive(:new).and_return(eftest_command))
    expect(eftest_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                namespaces: namespaces))

    RubyLeiningen.eftest(
        profile: profile,
        namespaces: namespaces)
  end

  it 'exposes a kibit helper function when kibit plugin required' do
    profile = 'test'
    replace = true

    kibit_command = double('kibit command')

    expect(RubyLeiningen::Commands::Kibit)
        .to(receive(:new).and_return(kibit_command))
    expect(kibit_command)
        .to(receive(:execute)
            .with(
                profile: profile,
                replace: replace))

    RubyLeiningen.kibit(
        profile: profile,
        replace: replace)
  end
end
