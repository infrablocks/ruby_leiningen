require 'spec_helper'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/cljstyle'

describe RubyLeiningen::Commands::Cljstyle do
  it 'calls the lein cljstyle subcommand in check mode by default' do
    command = RubyLeiningen::Commands::Cljstyle.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein cljstyle check', any_args))

    command.execute
  end

  it 'calls the lein cljstyle subcommand in fix mode when requested' do
    command = RubyLeiningen::Commands::Cljstyle.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein cljstyle fix', any_args))

    command.execute(mode: :fix)
  end

  it 'appends the supplied paths when provided' do
    command = RubyLeiningen::Commands::Cljstyle.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein cljstyle check some/path some/other/path', any_args))

    command.execute(paths: ["some/path", "some/other/path"])
  end
end
