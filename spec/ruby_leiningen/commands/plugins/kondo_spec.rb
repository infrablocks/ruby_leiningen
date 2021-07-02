require 'spec_helper'

require_relative '../../../support/shared_examples/profile_support'
require_relative '../../../support/shared_examples/environment_support'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/kondo'

describe RubyLeiningen::Commands::Kondo do
  it 'calls the lein kondo subcommand' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'kondo'
  it_behaves_like "a command with environment support", 'kondo'

  it 'passes the supplied lint path' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo --lint src', any_args))

    command.execute(path: 'src')
  end

  it 'passes the supplied cache directory' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo --cache-dir cache', any_args))

    command.execute(cache_directory: 'cache')
  end

  it 'passes the supplied config directory' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo --config-dir config', any_args))

    command.execute(config_dir: 'config')
  end

  it 'passes the supplied fail level' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo --fail-level warning', any_args))

    command.execute(fail_level: 'warning')
  end

  it 'passes the supplied cache flag' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo --cache', any_args))

    command.execute(cache: true)
  end

  it 'passes the supplied parallel flag' do
    command = RubyLeiningen::Commands::Kondo.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kondo --parallel', any_args))

    command.execute(parallel: true)
  end
end
