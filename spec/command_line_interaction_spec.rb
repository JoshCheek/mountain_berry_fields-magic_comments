require 'spec_helper'

describe ReadmeTester::CommandLineInteraction do
  let(:interaction) { described_class.new }
  let(:stderr)      { interaction.stderr.string }

  it 'implements the interaction interface' do
    Mock::Interaction.should substitute_for ReadmeTester::CommandLineInteraction, subset: true
  end

  specify '#declare_failure(message) writes messages to stderr, with newlines' do
    interaction.declare_failure "failure one"
    interaction.declare_failure "failure two"
    stderr.should == "failure one\nfailure two\n"
  end
end
