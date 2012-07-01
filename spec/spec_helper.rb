require 'surrogate/rspec'
require 'mountain_berry_fields'
require 'mountain_berry_fields/test/magic_comments.rb'


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
