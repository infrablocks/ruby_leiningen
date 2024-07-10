# frozen_string_literal: true

shared_examples(
  'a command with profile support'
) do |command_name, arguments = [], options = {}|
  let(:arguments_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  let(:command_string) { "#{command_name}#{arguments_string}" }
  let(:binary) { 'lein' }

  let(:executor) { Lino::Executors::Mock.new }

  before do
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
  end

  it 'uses the profile provided at execution' do
    command = described_class.new

    command.execute(
      options.merge(profile: 'some-profile')
    )

    expect(executor.executions.first.command_line.string)
      .to(match(/^#{binary}.* with-profile some-profile .*#{command_string}$/))
  end

  it 'uses the profile previously configured' do
    command = described_class.new.for_profile('some-profile')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(match(/^#{binary}.* with-profile some-profile .*#{command_string}$/))
  end

  it 'prefers the profile passed at execution time over that previously ' \
     'configured' do
    command = described_class.new.for_profile('some-profile')

    command.execute(profile: 'other-profile')

    expect(executor.executions.first.command_line.string)
      .to(match(/^#{binary}.* with-profile other-profile .*#{command_string}$/))
  end
end
