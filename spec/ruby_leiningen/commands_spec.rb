require 'spec_helper'

describe RubyLeiningen::Commands do
  after(:each) do
    RubyLeiningen::Commands.send(:remove_const, :Custom)
  end

  context '#define_custom_command' do
    it 'creates a command in the Commands module' do
      RubyLeiningen::Commands.define_custom_command('custom')

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      expect(Open4).to(
          receive(:spawn)
              .with('lein custom', any_args))

      command.execute
    end

    it 'includes profile support by default' do
      RubyLeiningen::Commands.define_custom_command('custom')

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      expect(Open4).to(
          receive(:spawn)
              .with('lein with-profile some-profile custom', any_args))

      command.execute(profile: 'some-profile')
    end

    it 'allows profile to be provided before execution' do
      RubyLeiningen::Commands.define_custom_command('custom')

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')
          .for_profile('some-profile')

      expect(Open4).to(
          receive(:spawn)
              .with('lein with-profile some-profile custom', any_args))

      command.execute
    end

    it 'does not include profile support when requested' do
      RubyLeiningen::Commands
          .define_custom_command('custom', include_profile_support: false)

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      expect(Open4).to(
          receive(:spawn)
              .with('lein custom', any_args))

      command.execute(profile: 'some-profile')
    end

    it 'allows command to be further configured via a block' do
      RubyLeiningen::Commands.define_custom_command('custom') do |config, opts|
        config.on_command_builder do |command|
          command = command.with_argument("thing")
          command = command.with_flag("--some-flag") if opts[:some_flag]
          command
        end
      end

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      expect(Open4).to(
          receive(:spawn)
              .with('lein --some-flag custom thing', any_args))

      command.execute(some_flag: true)
    end

    it 'allows subcommand to be further configured via a block' do
      RubyLeiningen::Commands.define_custom_command('custom') do |config, opts|
        config.on_subcommand_builder do |subcommand|
          subcommand = subcommand
              .with_flag("--some-flag") if opts[:some_flag]
          subcommand = subcommand
              .with_option("--some-option", 5) if opts[:some_option]
          subcommand
        end
      end

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      expect(Open4).to(
          receive(:spawn)
              .with('lein custom --some-flag', any_args))

      command.execute(some_flag: true)
    end
  end
end
