# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/ruby_leiningen/commands/plugins/bikeshed'
require_relative '../lib/ruby_leiningen/commands/plugins/cljfmt'
require_relative '../lib/ruby_leiningen/commands/plugins/cljstyle'
require_relative '../lib/ruby_leiningen/commands/plugins/eastwood'
require_relative '../lib/ruby_leiningen/commands/plugins/eftest'
require_relative '../lib/ruby_leiningen/commands/plugins/kibit'

RSpec.describe RubyLeiningen do
  it 'has a version number' do
    expect(RubyLeiningen::VERSION).not_to be_nil
  end

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a check helper function' do
    profile = 'test'

    check_command = instance_double(RubyLeiningen::Commands::Check)

    allow(RubyLeiningen::Commands::Check)
      .to(receive(:new)
            .and_return(check_command))
    allow(check_command).to(receive(:execute))

    described_class.check(profile: profile)

    expect(RubyLeiningen::Commands::Check)
      .to(have_received(:new))
    expect(check_command)
      .to(have_received(:execute)
            .with(profile: profile))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a clean helper function' do
    profile = 'test'

    clean_command = instance_double(RubyLeiningen::Commands::Clean)

    allow(RubyLeiningen::Commands::Clean)
      .to(receive(:new)
            .and_return(clean_command))
    allow(clean_command).to(receive(:execute))

    described_class.clean(profile: profile)

    expect(RubyLeiningen::Commands::Clean)
      .to(have_received(:new))
    expect(clean_command)
      .to(have_received(:execute)
            .with(profile: profile))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a deps helper function' do
    profile = 'test'

    deps_command = instance_double(RubyLeiningen::Commands::Deps)

    allow(RubyLeiningen::Commands::Deps)
      .to(receive(:new)
            .and_return(deps_command))
    allow(deps_command)
      .to(receive(:execute))

    described_class.deps(profile: profile)

    expect(RubyLeiningen::Commands::Deps)
      .to(have_received(:new))
    expect(deps_command)
      .to(have_received(:execute)
            .with(profile: profile))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a run helper function' do
    profile = 'test'
    main_function = 'mything.core/main'

    run_command = instance_double(RubyLeiningen::Commands::Run)

    allow(RubyLeiningen::Commands::Run)
      .to(receive(:new).and_return(run_command))
    allow(run_command).to(receive(:execute))

    described_class.run(profile: profile, main_function: main_function)

    expect(RubyLeiningen::Commands::Run)
      .to(have_received(:new))
    expect(run_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              main_function: main_function
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes an uberjar helper function' do
    profile = 'test'
    main_namespace = 'mything.core'

    uberjar_command = instance_double(RubyLeiningen::Commands::Uberjar)

    allow(RubyLeiningen::Commands::Uberjar)
      .to(receive(:new).and_return(uberjar_command))
    allow(uberjar_command).to(receive(:execute))

    described_class.uberjar(
      profile: profile,
      main_namespace: main_namespace
    )

    expect(RubyLeiningen::Commands::Uberjar)
      .to(have_received(:new))
    expect(uberjar_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              main_namespace: main_namespace
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a release helper function' do
    profile = 'prerelease'
    level = ':patch'

    release_command = instance_double(RubyLeiningen::Commands::Release)

    allow(RubyLeiningen::Commands::Release)
      .to(receive(:new).and_return(release_command))
    allow(release_command).to(receive(:execute))

    described_class.release(
      profile: profile,
      level: level
    )

    expect(RubyLeiningen::Commands::Release)
      .to(have_received(:new))
    expect(release_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              level: level
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a bikeshed helper function when bikeshed plugin required' do
    profile = 'test'
    maximum_line_length = 80

    bikeshed_command = instance_double(RubyLeiningen::Commands::Bikeshed)

    allow(RubyLeiningen::Commands::Bikeshed)
      .to(receive(:new).and_return(bikeshed_command))
    allow(bikeshed_command)
      .to(receive(:execute))

    described_class.bikeshed(
      profile: profile,
      maximum_line_length: maximum_line_length
    )

    expect(RubyLeiningen::Commands::Bikeshed)
      .to(have_received(:new))
    expect(bikeshed_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              maximum_line_length: maximum_line_length
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a cljfmt helper function when cljfmt plugin required' do
    profile = 'test'
    mode = :fix

    cljfmt_command = instance_double(RubyLeiningen::Commands::Cljfmt)

    allow(RubyLeiningen::Commands::Cljfmt)
      .to(receive(:new).and_return(cljfmt_command))
    allow(cljfmt_command).to(receive(:execute))

    described_class.cljfmt(
      profile: profile,
      mode: mode
    )

    expect(RubyLeiningen::Commands::Cljfmt)
      .to(have_received(:new))
    expect(cljfmt_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              mode: mode
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a cljstyle helper function when cljstyle plugin required' do
    profile = 'test'
    mode = :fix

    cljstyle_command = instance_double(RubyLeiningen::Commands::Cljstyle)

    allow(RubyLeiningen::Commands::Cljstyle)
      .to(receive(:new).and_return(cljstyle_command))
    allow(cljstyle_command).to(receive(:execute))

    described_class.cljstyle(
      profile: profile,
      mode: mode
    )

    expect(RubyLeiningen::Commands::Cljstyle)
      .to(have_received(:new))
    expect(cljstyle_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              mode: mode
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes an eastwood helper function when eastwood plugin required' do
    profile = 'test'

    eastwood_command = instance_double(RubyLeiningen::Commands::Eastwood)

    allow(RubyLeiningen::Commands::Eastwood)
      .to(receive(:new).and_return(eastwood_command))
    allow(eastwood_command).to(receive(:execute))

    described_class.eastwood(profile: profile)

    expect(RubyLeiningen::Commands::Eastwood)
      .to(have_received(:new))
    expect(eastwood_command)
      .to(have_received(:execute)
            .with(profile: profile))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes an eftest helper function when eftest plugin required' do
    profile = 'test'
    namespaces = %w[first.namespace second.namespace]

    eftest_command = instance_double(RubyLeiningen::Commands::Eftest)

    allow(RubyLeiningen::Commands::Eftest)
      .to(receive(:new).and_return(eftest_command))
    allow(eftest_command).to(receive(:execute))

    described_class.eftest(
      profile: profile,
      namespaces: namespaces
    )

    expect(RubyLeiningen::Commands::Eftest)
      .to(have_received(:new))
    expect(eftest_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              namespaces: namespaces
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations

  # rubocop:disable RSpec/MultipleExpectations
  it 'exposes a kibit helper function when kibit plugin required' do
    profile = 'test'
    replace = true

    kibit_command = instance_double(RubyLeiningen::Commands::Kibit)

    allow(RubyLeiningen::Commands::Kibit)
      .to(receive(:new).and_return(kibit_command))
    allow(kibit_command)
      .to(receive(:execute))

    described_class.kibit(
      profile: profile,
      replace: replace
    )

    expect(RubyLeiningen::Commands::Kibit)
      .to(have_received(:new))
    expect(kibit_command)
      .to(have_received(:execute)
            .with(
              profile: profile,
              replace: replace
            ))
  end
  # rubocop:enable RSpec/MultipleExpectations
end
