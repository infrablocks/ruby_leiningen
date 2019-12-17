require 'spec_helper'

require_relative '../../../../lib/ruby_leiningen/commands/plugins/eastwood'

describe RubyLeiningen::Commands::Eastwood do
  it 'calls the lein eastwood subcommand' do
    command = RubyLeiningen::Commands::Eastwood.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein eastwood', any_args))

    command.execute
  end

  it 'passes the provided config spend supplied' do
    command = RubyLeiningen::Commands::Eastwood.new(binary: 'lein')

    expect(Open4).to(
        receive(:spawn)
            .with('lein eastwood "{:namespaces [mylib.core]}"', any_args))

    command.execute(config: "{:namespaces [mylib.core]}")
  end
end
