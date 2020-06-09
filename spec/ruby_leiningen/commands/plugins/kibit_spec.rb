require 'spec_helper'

require_relative '../../../support/shared_examples/profile_support'
require_relative '../../../support/shared_examples/environment_support'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/kibit'

describe RubyLeiningen::Commands::Kibit do
  it_behaves_like "a command with profile support", 'kibit'
  it_behaves_like "a command with environment support", 'kibit'

  it 'calls the lein kibit subcommand' do
    command = RubyLeiningen::Commands::Kibit.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kibit', any_args))

    command.execute
  end

  it 'passes the provided replace flag' do
    command = RubyLeiningen::Commands::Kibit.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kibit --replace', any_args))

    command.execute(replace: true)
  end

  it 'passes the provided interactive flag' do
    command = RubyLeiningen::Commands::Kibit.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kibit --interactive', any_args))

    command.execute(interactive: true)
  end

  it 'passes the provided reporter option' do
    command = RubyLeiningen::Commands::Kibit.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kibit --reporter markdown', any_args))

    command.execute(reporter: "markdown")
  end

  it 'passes the provided paths' do
    command = RubyLeiningen::Commands::Kibit.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein kibit src/some/file.clj src/other/file.clj', any_args))

    command.execute(paths: ["src/some/file.clj", "src/other/file.clj"])
  end
end
