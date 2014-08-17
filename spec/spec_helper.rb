require 'bundler/setup'
require 'surrogate/rspec'
require 'mountain_berry_fields'
require 'mountain_berry_fields/autoloaded_strategies/magic_comments.rb'

# this should go into Surrogate itself
class RSpec::Expectations::ExpectationTarget
  alias was     to
  alias was_not to_not
end

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.disable_monkey_patching!
end

RSpec::Matchers.define :pass do
  match { |matcher| matcher.pass? }
end

module Mock
  class SyntaxChecker
    Surrogate.endow self
    define(:initialize) { |syntax| }
    define(:valid?) { true }
    define(:invalid_message) { "shit ain't valid" }
  end
end

MountainBerryFields::Test::MagicComments.override(:syntax_checker_class) { Mock::SyntaxChecker }
