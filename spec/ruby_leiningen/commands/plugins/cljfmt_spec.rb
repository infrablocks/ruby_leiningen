require 'spec_helper'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/cljfmt'

describe RubyLeiningen::Commands::Cljfmt do
  it 'calls the lein cljfmt subcommand in check mode by default' do
    command = RubyLeiningen::Commands::Cljfmt.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein cljfmt check', any_args))

    command.execute
  end

  it 'calls the lein cljfmt subcommand in fix mode when requested' do
    command = RubyLeiningen::Commands::Cljfmt.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein cljfmt fix', any_args))

    command.execute(mode: :fix)
  end

  it 'appends the supplied paths when provided' do
    command = RubyLeiningen::Commands::Cljfmt.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein cljfmt check some/path some/other/path', any_args))

    command.execute(paths: ["some/path", "some/other/path"])
  end
end
