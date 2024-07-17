# frozen_string_literal: true

require 'spec_helper'

describe RubyLeiningen::Commands do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  # rubocop:disable RSpec/RemoveConst
  after do
    Lino.reset!
    described_class.send(:remove_const, :Custom)
  end
  # rubocop:enable RSpec/RemoveConst

  describe '#define_custom_command' do
    it 'creates a command in the Commands module' do
      described_class.define_custom_command('custom')

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      command.execute

      expect(executor.executions.first.command_line.string)
        .to(eq('lein custom'))
    end

    it 'includes profile support by default' do
      described_class.define_custom_command('custom')

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      command.execute(profile: 'some-profile')

      expect(executor.executions.first.command_line.string)
        .to(eq('lein with-profile some-profile custom'))
    end

    it 'allows profile to be provided before execution' do
      described_class.define_custom_command('custom')

      command = RubyLeiningen::Commands::Custom
                .new(binary: 'lein')
                .for_profile('some-profile')

      command.execute

      expect(executor.executions.first.command_line.string)
        .to(eq('lein with-profile some-profile custom'))
    end

    it 'does not include profile support when requested' do
      described_class
        .define_custom_command('custom', include_profile_support: false)

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      command.execute(profile: 'some-profile')

      expect(executor.executions.first.command_line.string)
        .to(eq('lein custom'))
    end

    it 'allows command to be further configured via a block' do
      described_class.define_custom_command('custom') do |config, opts|
        config.on_command_builder do |command|
          command = command.with_argument('thing')
          command = command.with_flag('--some-flag') if opts[:some_flag]
          command
        end
      end

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      command.execute(some_flag: true)

      expect(executor.executions.first.command_line.string)
        .to(eq('lein --some-flag custom thing'))
    end

    it 'allows subcommand to be further configured via a block' do
      described_class.define_custom_command('custom') do |config, opts|
        config.on_subcommand_builder do |subcommand|
          if opts[:some_flag]
            subcommand = subcommand
                         .with_flag('--some-flag')
          end
          if opts[:some_option]
            subcommand = subcommand
                         .with_option('--some-option', 5)
          end
          subcommand
        end
      end

      command = RubyLeiningen::Commands::Custom.new(binary: 'lein')

      command.execute(some_flag: true)

      expect(executor.executions.first.command_line.string)
        .to(eq('lein custom --some-flag'))
    end
  end
end
