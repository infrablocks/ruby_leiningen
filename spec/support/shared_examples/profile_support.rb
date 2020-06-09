shared_examples(
    "a command with profile support"
) do |command_name, arguments = [], options = {}|
  let(:arguments_string) do
    arguments.empty? ? "" : " #{arguments.join(" ")}"
  end

  let(:command_string) { "#{command_name}#{arguments_string}" }
  let(:binary) { "lein" }

  it 'uses the profile provided at execution' do
    command = subject.class.new

    expect(Open4).to(
        receive(:spawn)
            .with(
                /^#{binary}.* with-profile some-profile .*#{command_string}$/,
                any_args))

    command.execute(
        options.merge(profile: "some-profile"))
  end

  it 'uses the profile previously configured' do
    command = subject.class.new.for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with(
                /^#{binary}.* with-profile some-profile .*#{command_string}$/,
                any_args))

    command.execute
  end

  it 'prefers the profile passed at execution time over that previously ' +
      'configured' do
    command = subject.class.new.for_profile('some-profile')

    expect(Open4).to(
        receive(:spawn)
            .with(
                /^#{binary}.* with-profile other-profile .*#{command_string}$/,
                any_args))

    command.execute(profile: 'other-profile')
  end
end