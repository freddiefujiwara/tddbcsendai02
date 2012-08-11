require 'rubygems'
require 'rspec'
require './fizzbuzz'

describe Fizzbuzz, "when empty" do
  before do
    @empty_fizzbuzz = Fizzbuzz.new
  end

  it "should return 4" do
    @empty_fizzbuzz.do(4).should == 4 
  end

  after do
    @empty_fizzbuzz = nil
  end
end
