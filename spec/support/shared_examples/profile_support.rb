# frozen_string_literal: true

shared_examples(
  'a command with profile support'
) do |command_name, arguments = [], options = {}|
  let(:arguments_string) do
    arguments.empty? ? '' : " #{arguments.join(' ')}"
  end

  let(:command_string) { "#{command_name}#{arguments_string}" }
  let(:binary) { 'lein' }

  it 'uses the profile provided at execution' do
    command = described_class.new

    allow(Open4).to(receive(:spawn))

    command.execute(
      options.merge(profile: 'some-profile')
    )

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              /^#{binary}.* with-profile some-profile .*#{command_string}$/,
              any_args
            ))
  end

  it 'uses the profile previously configured' do
    command = described_class.new.for_profile('some-profile')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              /^#{binary}.* with-profile some-profile .*#{command_string}$/,
              any_args
            ))
  end

  it 'prefers the profile passed at execution time over that previously ' \
     'configured' do
    command = described_class.new.for_profile('some-profile')

    allow(Open4).to(receive(:spawn))

    command.execute(profile: 'other-profile')

    expect(Open4)
      .to(have_received(:spawn)
            .with(
              /^#{binary}.* with-profile other-profile .*#{command_string}$/,
              any_args
            ))
  end
end
