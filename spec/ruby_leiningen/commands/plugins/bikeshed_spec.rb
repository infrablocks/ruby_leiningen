require 'spec_helper'

require_relative '../../../support/shared_examples/profile_support'
require_relative '../../../support/shared_examples/environment_support'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/bikeshed'

describe RubyLeiningen::Commands::Bikeshed do
  it 'calls the lein bikeshed subcommand' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed', any_args))

    command.execute
  end

  it_behaves_like "a command with profile support", 'bikeshed'
  it_behaves_like "a command with environment support", 'bikeshed'

  it 'passes the supplied show help flag' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --help-me', any_args))

    command.execute(show_help: true)
  end

  it 'passes the supplied verbose flag' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --verbose', any_args))

    command.execute(verbose: true)
  end

  it 'passes the supplied maximum line length' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --max-line-length 120', any_args))

    command.execute(maximum_line_length: 120)
  end

  it 'passes the supplied long lines option' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --long-lines false', any_args))

    command.execute(long_lines: false)
  end

  it 'passes the supplied trailing whitespace option' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --trailing-whitespace false', any_args))

    command.execute(trailing_whitespace: false)
  end

  it 'passes the supplied trailing blank lines option' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --trailing-blank-lines false', any_args))

    command.execute(trailing_blank_lines: false)
  end

  it 'passes the supplied var redefs option' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --var-redefs false', any_args))

    command.execute(var_redefs: false)
  end

  it 'passes the supplied docstrings option' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --docstrings false', any_args))

    command.execute(docstrings: false)
  end

  it 'passes the supplied name collisions option' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --name-collisions false', any_args))

    command.execute(name_collisions: false)
  end

  it 'passes the supplied excluded profiles' do
    command = RubyLeiningen::Commands::Bikeshed.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein bikeshed --exclude-profiles dev,repl', any_args))

    command.execute(exclude_profiles: ["dev", "repl"])
  end
end
