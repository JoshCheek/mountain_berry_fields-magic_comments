require 'spec_helper'

test_class = MountainBerryFields::Test

RSpec.describe test_class::MagicComments do
  it 'is registered it the strategy list under :magic_comments' do
    expect(test_class::Strategy.for :magic_comments).to eq described_class
  end

  specify '#pass? returns true if the output is the same as the input' do
    expect(described_class.new '1 + 1 # => 2').to pass
    expect(described_class.new '1 + 2 # => 2').not_to pass
    expect(described_class.new "a=1\nb=2\na+b # => 3").to pass
  end

  it 'ignores warnings in the output' do
    expect(described_class.new "1").to pass
  end

  it 'ignores differences that look like object inspections' do
    expect(described_class.new "Object.new # => #<Object:0x007f9ef108b578>").to pass
    expect(described_class.new "Object.new # => #<NotObject:0x007f9ef108b578>").not_to pass
    expect(described_class.new "Class.new.new # => #<#<Class:0x007fc6d388b548>:0x007fc6d388b4f8>").to pass
  end

  describe '#failure_message' do
    it "provides Ruby's syntax message if the syntax is not valid" do
      magic_comments = described_class.new '}'
      syntax_checker = magic_comments.syntax_checker
      expect(syntax_checker).was initialized_with '}'
      syntax_checker.will_have_valid? false  # should surrogate provide: will_be_valid? ?
      syntax_checker.will_have_invalid_message "} ain't no kinda valid"
      expect(magic_comments).not_to pass
      expect(magic_comments.failure_message).to eq "} ain't no kinda valid"
    end

    it 'identifies the first output line that differs from the input' do
      magic_comments = described_class.new <<-CODE.gsub(/^\s*/, '')
        1 + 2     # => 3
        "a" + "b" # => "ba"
        5 + 6     # => 345678
      CODE
      magic_comments.pass?
      expect(magic_comments.failure_message).to eq \
        %Q(Expected: "a" + "b" # => "ba"\n) +
        %Q(Actual:   "a" + "b" # => "ab"\n)
    end

    it 'strips leading white spaces off of failures' do
      magic_comments = described_class.new("    \t\t   1 + 1 # => 4")
      magic_comments.pass?
      expect(magic_comments.failure_message).to eq \
        %Q(Expected: 1 + 1 # => 4\n) +
        %Q(Actual:   1 + 1 # => 2\n)
    end

    it 'identifies missing output' do
      magic_comments = described_class.new("puts 1\nputs 2\n")
      magic_comments.pass?
      expect(magic_comments.failure_message).to eq "Output had extra line: \n"\
                                                   "Output had extra line: # >> 1\n"\
                                                   "Output had extra line: # >> 2\n"
    end

    it 'identifies missing input' do
      magic_comments = described_class.new("puts 1\n\n# >> 1\n# >> 2\n# >> 3\n")
      magic_comments.pass?
      expect(magic_comments.failure_message).to eq "Input had extra line: # >> 2\n"\
                                                   "Input had extra line: # >> 3\n"
    end
  end
end
