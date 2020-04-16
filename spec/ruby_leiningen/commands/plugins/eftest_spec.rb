require 'spec_helper'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/eftest'

describe RubyLeiningen::Commands::Eftest do
  it 'calls the lein eftest subcommand' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein eftest :all', any_args))

    command.execute
  end

  it 'passes the provided test selectors' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein eftest :unit :integration', any_args))

    command.execute(test_selectors: [:unit, :integration])
  end

  it 'passes the provided namespaces' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein eftest mylib.core mylib.helpers :all', any_args))

    command.execute(namespaces: ["mylib.core", "mylib.helpers"])
  end

  it 'passes the provided files' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with(
                'lein eftest src/mylib/core.clj src/mylib/helpers.clj :all',
                any_args))

    command.execute(files: ["src/mylib/core.clj", "src/mylib/helpers.clj"])
  end

  it 'allows test selectors and namespaces' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with(
                'lein eftest mylib.core mylib.helpers :unit :integration',
                any_args))

    command.execute(
        namespaces: ["mylib.core", "mylib.helpers"],
        test_selectors: [:unit, :integration])
  end

  it 'allows class based test selectors' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with(
                'lein eftest mylib.core mylib.helpers some.namespace/test-something :integration',
                any_args))

    command.execute(
        namespaces: ["mylib.core", "mylib.helpers"],
        test_selectors: ["some.namespace/test-something", :integration])
  end

  it 'allows the only test selector' do
    command = RubyLeiningen::Commands::Eftest.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with(
                'lein eftest :only some.namespace/test-something',
                any_args))

    command.execute(
        only: "some.namespace/test-something")
  end
end
